#!/usr/bin/perl
#
#   Packages and modules
#
use strict;
use warnings;
use version;         our $VERSION = qv('5.16.0');   # This is the version of Perl to be used
use Statistics::R;

my $infilename;

#
#   Check that you have the right number of parameters
#
if ($#ARGV != 0 ) {
    print "Usage: plotNames.pl <input file name> <pdf file name>\n" or
    die "Print failure\n";
    exit;
} else {
    $infilename = $ARGV[0];
}

# Create a communication bridge with R and start R
my $R = Statistics::R->new();


# Set up the PDF file for plots
$R->run(qq`pdf("output.pdf" , paper="letter")`);

# Load the plotting library
$R->run(q`library(ggplot2)`);

# read in data from a CSV file
$R->run(qq`data <- read.csv("$infilename")`);

# plot the data as a line plot with each point outlined
$R->run(q`ggplot(data, aes(x=Year, y=Value)) + geom_line() + geom_point(size=2) + ylab("Value")+xlab("Year")  `);
# close down the PDF device
$R->run(q`cmd<-"open output.pdf"`);
$R->run(q`Sys.sleep(1)`);
$R->run(q`system(cmd,wait=FALSE)`);
$R->run(q`dev.off()`);

$R->stop();