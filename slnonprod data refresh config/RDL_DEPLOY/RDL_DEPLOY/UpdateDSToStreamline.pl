#!/usr/bin/perl

use File::Find;

foreach $File (@ARGV)
{

	    my @outLines;  #Data we are going to output
	    my $line;      #Data we are reading line by line
	    print "processing $File\n";
	
	
	       open(FILE, $File) ||
	       die("Couldn't open $File: $!\n");
	
	       while ($line = <FILE> ) {
		if($line =~ m/<DataSource Name=(.*?)>/)
		{
			$line =~ s/$1/\x22Streamline\x22/;			
		}
		if($line =~ m/<DataSourceReference>(.*?)<\/DataSourceReference>/)
		{
			$line =~ s/$1/Streamline/;			
		}
		if($line =~ m/<DataSourceName>(.*?)<\/DataSourceName>/)
		{
			$line =~ s/$1/Streamline/;
		}
		
			push(@outLines, $line);
		
	       }
	   close FILE;
	
	        open ( OUTFILE, ">$File" ) or 
	        die "Cannot open file: $!";
	
	        print ( OUTFILE @outLines );
	        close ( OUTFILE );
	        
	        undef( @outLines );
}