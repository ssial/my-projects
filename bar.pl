#!/usr/bin/perl

use strict;
use warnings;
use version;	our $VERSION =qv('5.16.0');
use Statistics::R;
my $infile;
my $R = Statistics::R->new();
$infile=$ARGV[0];

$R->run(qq`pdf("barO4.pdf",paper="letter")`);

$R->run(q`library(ggplot2)`);

$R->run(qq`data<-read.csv("$infile")`);
$R->run(q`ggplot(data,aes(x=Year,y=Value,fill=Name),xaxt="n",yaxt="n",labels=(data$Year))+stat_summary(geom="bar",position=position_dodge(width=1),size=.5)+theme(legend.position="bottom",legend.key.size=unit(5,"mm"),legend.text=element_text(colour='black',size=6))+guides(fill=guide_legend(ncol=3))+scale_fill_discrete(name="legend")`);


$R->run(q`cmd<-"open barO4.pdf"`);
$R->run(q`Sys.sleep(1)`);
$R->run(q`system(cmd,wait=FALSE)`);
$R->run(q`dev.off()`);
$R->stop();