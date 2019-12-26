#!/usr/bin/perl
# use Data::Dumper;

# if only one version exsits assume it's the latest
if(keys @ARGV == 1)
{
	print $ARGV[0];
	exit;
}

# obtain latest version of firefox tar ball

$debug = 0;
%tar_balls;
for my $tar_ball (@ARGV)
{
	$tar_ball =~ m/(\d+)\.(\d+)\.(\d+)?/;
	$tar_balls{$tar_ball} = [$1, $2, $3];
}


# print STDERR Dumper \%tar_balls if $debug;


# compare version numbers, first $1 then $2 then $3

$hi = 0; # highest index
$eq = 0; # multiple high ones
$v = 0;
@keys = keys %tar_balls;
# print STDERR Dumper \@keys if $debug;

do
{
	$eq = 0;
	$hi = 0;
	$i = 0;
	for my $key (@keys)
	{
		my $next_key = $keys[$i+1];
		last unless defined $next_key;
		my $a = $tar_balls{$key}[$v]; 
		my $b = $tar_balls{$next_key}[$v];
		$eq++ if $a == $b;
		$hi = $a > $b ? $key : $next_key;
		$i++;
	}
	$v++;
}
while($eq > 0 and $v < $size);
print $hi;
