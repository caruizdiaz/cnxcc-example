#
# Authentication, Authorization & Accounting (AAA) script
# 
# Carlos Ruiz Diaz | Kamailio World 2014
# carlos.ruizdiaz@gmail.com
# http://caruizdiaz.com
#

use strict;
use warnings;

require '/home/cnxcc/kamailio/AAA/db.pm';

use lib '/usr/local/lib64/kamailio/perl/';
use Kamailio qw ( log );
use Kamailio::Constants;
use Kamailio::Message;

use constant L_CRIT	=> -2;
use constant L_ERR 	=> -1;
use constant L_NOTICE 	=> 1;
use constant L_INFO 	=> 2;

use constant AAA_INTERNAL_ERROR => -2;
use constant AAA_NOT_AUTHORIZED => -1;
use constant AAA_AUTHORIZED 	=> 1;

sub bill_call_on_forced_end {
	my $m		= shift;
	my $duration	= shift;
	
	my $subscriber	= $m->pseudoVar('$var(subscriber)');
	my $destination	= $m->pseudoVar('$var(destination)');
	my $cps		= $m->pseudoVar('$var(cost_per_second)');
	my $i_cost	= $m->pseudoVar('$var(i_cost)');
	my $f_cost	= $m->pseudoVar('$var(f_cost)');
	my $billable	= $m->pseudoVar('$var(billable)');

	return do_billing($m, $duration, $subscriber, $destination, $cps, $i_cost, $f_cost);
}

sub bill_call {
	my $m		= shift;
	my $duration	= shift;
	
	my $subscriber	= $m->pseudoVar('$dlg_var(subscriber)');
	my $destination	= $m->pseudoVar('$dlg_var(destination)');
	my $cps		= $m->pseudoVar('$dlg_var(cost_per_second)');
	my $i_cost	= $m->pseudoVar('$dlg_var(i_cost)');
	my $f_cost	= $m->pseudoVar('$dlg_var(f_cost)');
	my $billable	= $m->pseudoVar('$dlg_var(billable)');

	return do_billing($m, $duration, $subscriber, $destination, $cps, $i_cost, $f_cost);
}

sub do_billing {
	my ($m, $duration, $subscriber, $destination, $cps, $i_cost, $f_cost, $billable) = @_;
	my $dbh	= connect_to_cnxcc_db();

	if (!defined $dbh) {
		return AAA_INTERNAL_ERROR;
	}

	
	log(L_INFO, "$cps, $i_cost, $f_cost, $cps | $duration \n");

	my $secs_left	= $duration - $i_cost;
	my $rounder	= $secs_left % $f_cost == 0 ? 0 : 1;
	my $cost	= ($secs_left / $f_cost) + $rounder;

	if ($secs_left > 0) {
		$cost	= ($i_cost * $cps ) + ($cost * ($f_cost * $cps));
	}

	if ($billable ne 'no') {
		update_subscriber_credit($dbh, $subscriber, $cost);
		log(L_INFO, "Call costed [$cost] USD, at $cps USD per sec.\n");
	}
	else {
		log(L_INFO, "Removing cost and duration for call from [$subscriber] to [$destination] because it is not billable\n");
		$duration	= 0;
		$cost		= 0;
	}

	if (!insert_cdr($dbh, $subscriber, 
			$destination, $duration, 
			$cost, $m->pseudoVar('$ci'), 
			$m->pseudoVar('$ft'), $m->pseudoVar('$tt'), 
			$m->pseudoVar('$dlg_var(direction)'))) {
		log(L_ERR, "Error inserting cdr for call from [$subscriber] to [$destination]\n");
		return -1;
	}

	return 1;
}

sub authorize {
	my $m		= shift;

	my $subscriber	= $m->pseudoVar('$fU');
	my $destination	= $m->pseudoVar('$rU');
	
	my $dbh	= connect_to_cnxcc_db();

	if (!defined $dbh) {
		return AAA_INTERNAL_ERROR;
	}

	my $is_call 	= $m->getMethod() eq 'INVITE' ? 1 : 0; # it can be a MESSAGE too, just saying ;)
	my $price	= get_price($dbh, $subscriber, $destination);
	
	if (!defined $price) {
		log(L_ERR, "Call price not defined for subscriber [$subscriber]\n");
		return AAA_NOT_AUTHORIZED;
	}

	my $credit	= get_credit($dbh, $subscriber);
	my $cost	= $price->{outbound_call_cps};
	
	if ($is_call) {
		Kamailio::AVP::add("credit", "$credit");
		Kamailio::AVP::add("initial_cost", $price->{initial_cost});
		Kamailio::AVP::add("final_cost", $price->{final_cost});
		Kamailio::AVP::add("o_call_cps", $cost);
	}
	elsif (!$is_call && $credit >=$cost) {
		# maybe we want to bill MESSAGE requests. It can be done with the same logic
		;
	}

	if (($is_call && $price->{outbound_call_cps} == 0)) {
		log(L_INFO, "Free call/sms for subscriber [$subscriber] to [$destination]\n");
		
		return AAA_AUTHORIZED;
	}
	
	my $op	= $is_call ? 'Call' : 'SMS';

	if ($credit < $cost) {
		log(L_INFO, "$op NOT authorized for subscriber [$subscriber] to [$destination]. Credit [$credit], Cost [$cost]\n");
		return AAA_NOT_AUTHORIZED;
	}

	log(L_INFO, "$op authorized for subscriber [$subscriber] to [$destination]\n");

	return AAA_AUTHORIZED;
}

sub get_subscriber_credit {
	my $m           = shift;
        my $subscriber  = $m->pseudoVar('$fU');
	my $dbh 	= connect_to_cnxcc_db();

        if (!defined $dbh) {
                return AAA_INTERNAL_ERROR;
        }
		
	my $credit	= get_credit($dbh, $subscriber);
	
	Kamailio::AVP::add("credit", "$credit");
	
	return AAA_AUTHORIZED;
}

1;
