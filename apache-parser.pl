use strict;
use POSIX;

my $start_time=time();
my $sourceFileName = "filepath\\input.txt";
my $accessLogFileName = "destinationfilepath\\output.csv";
open(FILE, "<$sourceFileName") || die "File not found";
my @lines = <FILE>;
close(FILE);

my @newlines;
foreach(@lines) {
	if($_ =~ /GET/){
	    $_ =~ s/- -//g;
   		$_ =~ s/ /,/g;
   		$_ =~ s/\]//g;
   		$_ =~ s/\[//g;
   		$_ =~ s/\"//g;
   		$_ =~ s/,,/,/g;
   		push(@newlines,$_);
	}
	elsif($_ =~ /POST/){
		$_ =~ s/- -//g;
   		$_ =~ s/ /,/g;
   		$_ =~ s/\]//g;
   		$_ =~ s/\[//g;
   		$_ =~ s/\"//g;
   		$_ =~ s/,,/,/g;
   		push(@newlines,$_);
	}
}

my @formatOutput;
my @formatString;
my $queryString;
my $mergeOp;

foreach(@newlines){
	@formatString = split /,/,$_;
	if($formatString[7]  ne " "){
	my $strLength = length($formatString[7]);
	my $position = rindex($formatString[7], "/");
	$queryString = substr($formatString[7],$position+1,$strLength);
	if($queryString =~ m/&timestamp=/){
	$queryString =~ s/\?_=(\d+)//g;
	$queryString =~ s/&timestamp=(\d+)//g;
	}
	elsif($queryString =~ m/downloadContent?fileName=/){
	$queryString = substr($queryString,0,15);	
	}
	else {
		$queryString =~ s/\?_=(\d+)//g;	
	 }
	}
	$mergeOp = join(',',$formatString[4],$formatString[0],$formatString[1],$formatString[2],$formatString[3],
				$formatString[5],$formatString[6],$queryString,$formatString[8],$formatString[9],$formatString[10]);
	push(@formatOutput,$mergeOp);
}

open(FILE, ">$accessLogFileName") || die "File not found";
print FILE "RequestTimeStamp,Hostname,RequestServiceTimeMsec,RequestServiceTimeSec,FirstByteWriteTime,TimeZone,HTTPMethod,RequestName,HTTPProtocol,HTTPStatusCode,BytesSent\n";
print FILE @formatOutput;
close(FILE);
my $end_time=time();
my $run_time = $end_time - $start_time;
print "Parsing Completed in $run_time seconds";
