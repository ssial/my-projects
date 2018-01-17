#!/usr/bin/perl

use strict;
use warnings;
use version;	our $VERSION =qv('5.16.0');
use Statistics::R;
my $infile;
my $R = Statistics::R->new();
$infile=$ARGV[0];

$R->run(qq`pdf("scatter.pdf",paper="letter")`);

$R->run(q`library(ggplot2)`);

$R->run(qq`data<-read.csv("$infile")`);

$R->run(q`plot(x=data$Year,y=data$Value,xlab="Year ",ylab="Value ",pch=19)+abline(lm(data$Value~data$Year),col="red")`);
$R->run(q`cmd<-"open scatter.pdf"`);
$R->run(q`Sys.sleep(1)`);
$R->run(q`system(cmd,wait=FALSE)`);
$R->run(q`dev.off()`);
$R->stop();
