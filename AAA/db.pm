#
# DB abstraction for AAA script
# 
# Carlos Ruiz Diaz | Kamailio World 2014
# carlos.ruizdiaz@gmail.com
# http://caruizdiaz.com
#

use DBI;
use DBD::mysql;

use constant K_DB         => 'cnxcc';
use constant K_USER       => 'cnxcc';
use constant K_PWD        => 'kw2014';
use constant K_HOST       => 'localhost';

sub connect_to_cnxcc_db()
{
	return connect_to_db(K_DB, K_HOST, K_USER, K_PWD);
}

sub connect_to_db($$$$$)
{
	my ($db, $host, $user, $pwd) 	= @_;	

        my $dsn = "DBI:mysql:$db:$host";

        return DBI->connect($dsn, $user, $pwd) || die "Could not connect to database: $DBI::errstr";
}

sub is_correctly_formatted($$)
{
	my ($text, $result) = @_;

	if ($text =~ m/^595\d{4}/g) {
		$result->{to_number} = $&; 
		return 1;
	}

	return 0;
}

sub get_price($$$)
{
	my ($dbh, $subscriber, $destination)	= @_;
	my $candidate			= undef;	

	my $query	= $dbh->prepare("SELECT subscriber, prefix, LENGTH(prefix) AS l, price.* ".
						"FROM price WHERE subscriber = '$subscriber' ".
						"OR subscriber = '*' ORDER BY subscriber DESC") or return undef;

        $query->execute() or return undef;

	while ( my $row = $query->fetchrow_hashref() ) {
		my ($this_subs, $prefix, $length) = ($$row{subscriber}, $$row{prefix}, $$row{l});
		my $destination_prefix;		
	
		if ($this_subs eq '*' && defined $candidate) {
			next;
		}

		if ($destination !~ m/^$prefix/g) {
			next;
		}

		$destination_prefix	= $&;

		if ($destination_prefix eq $prefix) {
			$candidate	= $row;
		}
	}

	return $candidate;	
}

sub get_credit($$)
{
	my ($dbh, $subscriber)	= @_;

	my $query       = $dbh->prepare("SELECT credit FROM credit WHERE subscriber = '$subscriber' ") or return 0;

	$query->execute() or return 0;

	my $row = $query->fetchrow_hashref();
	
	if (!defined $row) {
		return 0;
	}
	
	return $$row{credit};
}

sub update_subscriber_credit($$$)
{
	my ($dbh, $subscriber, $cost)	= @_;

	$dbh->do("UPDATE credit SET credit = credit - $cost WHERE subscriber = '$subscriber'") or die("$!\n");
}

sub insert_cdr($$$$$$$$$)
{
	my ($dbh, $subscriber, $destination, $duration, $cost, $callid, $from_tag, $to_tag, $direction) = @_;

	
	$dbh->do("INSERT INTO cdr(subscriber, destination, duration, cost, callid, from_tag, to_tag, direction) VALUES('$subscriber', '$destination',
												$duration, '$cost', '$callid', 
												'$from_tag', '$to_tag', '$direction')") or return 0;
	return 1;

}

1;
