#!usr/bin/perl

use strict;
use warnings;
use version;   our $VERSION = qv('5.16.0');   # This is the version of Perl to be used
use Text::CSV  1.32;   # We will be using the CSV module (version 1.32 or higher)
                       # to parse each line
#
#   Variables used
#
my $EMPTY = q{};
my $SPACE = q{ };
my $COMMA = q{,};
my $csv = Text::CSV->new({ sep_char => $COMMA });
my $quit;
my $graph;
my $graph_type;
my @records;
my @records2;
my @records3;
my $record_count;
my $record_count2;
my $record_count3;
my @stat;
my @geo;
my @statNum;
my @geoNum;
my @violation;
my @violation_num;
my @time_period;
my @array;
my $start;
my $end;
my $final_selection;
my $final_selection2;
my $final_selection3;
my $filename = "questions.txt";
my $filename1 = "statistics.csv";
my $filename2 = "geo.csv";
my $filename3 = "violations.csv";
my $q_selection;
my $y_selection;
my $calculation;
my $stat_selection;
my $stat_selection2;
my $vio_selection;
my $vio_selection2;
my $count;
my $geo_selection;
my $geo_selection2;
my $y_start;
my $y_end;
my $y_single;
my $data_encoding;
my $data_encoding2;
my $general_select = 0;
my $final_selection2_2;
my $final_selection2_1;
my $lineNum;
my $lineNum2;
my $line;
my $line1;
my $line2;
my $input;
my $num1;
my $num2;
my $counter;
my $charSelection;
my @stat_choice2 = qw/2 8 10 12 14/;
my @stat_choice7 = qw/7 9 11 13/;
my @vio_choice = qw/1 4 64 225 148 175 231 205/;
my @vio_choice4 = qw/4 5 6 7 8 9 10 13 16 226 26 30 34 227 38 256/;
my @vio_choice64 = qw/64 68 228 69 80 223/;
my @vio_choice225 = qw/225 85 86 98 99/;
my @vio_choice148 = qw/148 149 160/;
my @vio_choice231 = qw/231 183 187 191/;
my @geo_choice2 = qw/2 4 5 7 9 16 28 30 33 36 40 41 42/;
my @geo_choice3 = qw/2 7 16/;
my @geo_choice3_2 = qw/3/;
my @geo_choice3_7 = qw/43 8/;
my @geo_choice3_16 = qw/19 46 23/;
my @general_select_22 = qw/3 43 8 19 46 23/;
my @all_violations = qw/1 4 64 225 148 175 231 205 5 6 7 8 9 10 13 16 226 26 30 34 227 38 256 64 68 228 69 80 223 225 85 86 98 99 148 149 160 231 183 187 191/;
my @census_provinces = qw/10 11 12 13 24 35 46 47 48 59 60 61 62/;

my $census_filename = $EMPTY;
my $crime_filename = $EMPTY;
my $census_record_cnt = -1;
my $crime_record_cnt = -1;
my @census;
my @geocode_census;
my @prov_name_census;
my @topic_census;
my @characteristic_census;
my @note_census;
my @total_census;
my @flag_total_census;
my @male_count_census;
my @flag_male_census;
my @female_count_census;
my @flag_female_census;
my @crime;
my @date_crime;
my @geocode_crime;
my @violation_crime;
my @STA_crime;
my @vector_crime;
my @coordinate_crime;
my @value_crime;
my @found_data;
my @found_data2;
my @top_values;
my $write_filename = "datapoints.txt";
my $command = $EMPTY;
my $answer;


#
#   Ensure the right number of parameters
#
if ($#ARGV != 1 ) {
   print "Usage: QueryEngine.pl <census file> <crime file>\n" or
      die "Print failure\n";
   exit;
} else {
   $census_filename = $ARGV[0];
   $crime_filename = $ARGV[1];
}

#
#   Open files and load contents into arrays
#

print "Loading file content...\n";
sub printMenu {
    open my $FILE, '<', $filename
    or die "Unable to open file\n";
    
    #   Prints questions manu to user
    while (<$FILE>) {
        print $_;
    }
    
    close $FILE or
    die "Unable to close\n";
}

open my $fh, '<', $census_filename or
   die "Unable to open census file: $census_filename\n";

@census = <$fh>;

close $fh or
   die "Unable to close: $census_filename\n";


open $fh, '<', $crime_filename or
   die "Unable to open crime file: $crime_filename\n";

@crime = <$fh>;

close $fh or
   die "Unable to close: $ARGV[1]\n";

#   Stores statistics encodings file into array
open my $stats_fh, '<', $filename1
   or die "Unable to open file\n";

@records = <$stats_fh>;

close $stats_fh or
   die "Unable to close\n";


#   Stores geo encodings file into array
open my $geo_fh, '<', $filename2
   or die "Unable to open file\n";

@records2 = <$geo_fh>;

close $geo_fh or
   die "Unable to close\n";


#   Stores violations encodings into array
open my $violation_fh, '<', $filename3
   or die "Unable to open file\n";

@records3 = <$violation_fh>;

close $violation_fh or
   die "Unable to close\n";

#
#   Parse each line and store the information in arrays
#   representing each field
#
#   Extract each field from each name record as delimited by a comma
#

foreach my $census_fh ( @census ) {
   if ( $csv->parse($census_fh) ) {
      my @master_fields = $csv->fields();
      $census_record_cnt++;
      $geocode_census[$census_record_cnt] = $master_fields[0];
      $prov_name_census[$census_record_cnt] = $master_fields[1];
      $topic_census[$census_record_cnt] = $master_fields[2];
      $characteristic_census[$census_record_cnt] = $master_fields[3];
      $note_census[$census_record_cnt] = $master_fields[4];
      $total_census[$census_record_cnt] = $master_fields[5];
      $flag_total_census[$census_record_cnt] = $master_fields[6];
      $male_count_census[$census_record_cnt] = $master_fields[7];
      $flag_male_census[$census_record_cnt] = $master_fields[8];
      $female_count_census[$census_record_cnt] = $master_fields[9];
      $flag_female_census[$census_record_cnt] = $master_fields[10];
   } else {
      warn "Line/record could not be parsed: $census[$census_record_cnt]\n";
   }
}

foreach my $crime_fh ( @crime ) {
   if ( $csv->parse($crime_fh) ) {
      my @master_fields = $csv->fields();
      $crime_record_cnt++;
      $date_crime[$crime_record_cnt] = $master_fields[0];
      $geocode_crime[$crime_record_cnt] = $master_fields[1];
      $violation_crime[$crime_record_cnt] = $master_fields[2];
      $STA_crime[$crime_record_cnt] = $master_fields[3];
      $vector_crime[$crime_record_cnt] = $master_fields[4];
      $coordinate_crime[$crime_record_cnt] = $master_fields[5];
      $value_crime[$crime_record_cnt] = $master_fields[6];
 
   } else {
      warn "Line/record could not be parsed: $crime[$crime_record_cnt]\n";
   }
}

foreach my $stat_record (@records) {
    if ($csv->parse($stat_record)) {
        my @stat_fields = $csv->fields();
        $record_count++;
        $statNum[$record_count] = $stat_fields[0];
        $stat[$record_count] = $stat_fields[1];
    }
    else {
        warn "Line could not be parsed: $records[$record_count]\n";
    }
}

foreach my $geo_record (@records2) {
    if ($csv->parse($geo_record)) {
        my @location_fields = $csv->fields();
        $record_count2++;
        $geoNum[$record_count2] = $location_fields[2];
        $geo[$record_count2] = $location_fields[3];
    }
    else {
        warn "Line could not be parsed\n";
    }
}

foreach my $violation_record (@records3) {
    if ($csv->parse($violation_record)) {
        my @violation_fields = $csv->fields();
        $record_count3++;
        $violation_num[$record_count3] = $violation_fields[2];
        $violation[$record_count3] = $violation_fields[3];
    }
    else {
        warn "Line could not be parsed\n";
    }
}

#
#   Input subroutines
#

sub is_integer {
    
    no warnings qw/numeric/;
    if ($input eq int($input) && $input >= $num1 && $input <= $num2) {
        return 1;
    } else {
        return 0;
    }
}

sub in_array {
    
    for (@array) {
        no warnings qw/numeric/;
        if ($input eq int($input) && $input eq $_) {
            return 1;
        } else {
            $counter++;
        }
    }
    if ($counter eq $#array + 1) {
        return 0;
    }
    
}

sub loop {
    $input = <STDIN>;
    chomp $input;
    while(!is_integer($input,$num1,$num2)) {
        print "Incorrect input. Please try again: ";
        $input = <STDIN>;
        chomp $input;
    }
    return $input;
}


sub loop2 {
    $input = <STDIN>;
    chomp $input;
    while(!in_array($input,@array)) {
        print "Incorrect input. Please try again: ";
        $input = <STDIN>;
        chomp $input;
    }
    return $input;
}

sub print_options {
    
    for my $j($start..$end+$start-1) {
        print "$statNum[$j] $stat[$j]\n";
    }
    
}

sub print_options3 {
    
    for my $j($start..$end-1) {
        print "$violation_num[$j] $violation[$j]\n";
    }
    
}

sub print_options2 {
    
    for my $j($start..$end+$start-1) {
        print "$geoNum[$j] $geo[$j]\n";
    }
    
}

sub line_number {
    my $line_num = 0;
    for my $k(1..$count) {
        $line_num++;
        if ($statNum[$k] eq $final_selection) {
            return $line_num;
        }
    }
}

sub line_number2 {
    my $line_num = 0;
    for my $k(1..$count) {
        $line_num++;
        if ($geoNum[$k] eq $geo_selection) {
            return $line_num;
        }
    }
}

sub line_number3 {
    my $line_num = 0;
    for my $k(1..$count) {
        $line_num++;
        if ($violation_num[$k] eq $vio_selection) {
            return $line_num;
        }
    }
}

#
#   More input subroutines
#

sub stats_selections {
    
    
    for my $i (1..7) {
        print "$statNum[$i] $stat[$i]\n";
    }
    
    print "\nPlease select an option from the statistics (1-7): ";
    $num1 = 1;
    $num2 = 7;
    $stat_selection = loop($num1,$num2);
    
    
    if ($stat_selection eq 2) {
        $start = 11;
        $end = 4;
        
        print "$statNum[$stat_selection] $stat[$stat_selection]\n";
        print_options($start,$end);
        print "\n";
        print "Please specify which type of statistic you wish to choose: ";
        @array = @stat_choice2;
        $stat_selection2 = loop2(@array);
        $final_selection = $stat_selection2;
    }
    
    elsif ($stat_selection eq 7) {
        $start = 8;
        $end = 3;
        
        print "$statNum[$stat_selection] $stat[$stat_selection]\n";
        print_options($start,$end);
        print "\n";
        print "Please specify which type of statistic you wish to choose: ";
        @array = @stat_choice7;
        $stat_selection2 = loop2(@array);
        $final_selection = $stat_selection2;
    }
    
    else {
        $final_selection = $stat_selection;
    }
    return $final_selection;

    
}

sub violation_selections {
    
    for my $n (1..8) {
        print "$violation_num[$n] $violation[$n]\n";
    }
    
    print "\nPlease select a violation from the list by entering the number beside it: ";
    @array = @vio_choice;
    $vio_selection = loop2(@array);
    
    
    if ($vio_selection eq 4) {
        $start = 9;
        $end = 24;
        $line1 = line_number3($vio_selection, $count);
        print "$violation_num[$line1] $violation[$line1]\n";
        print_options3($start, $end);
        print "\nPlease select a violation from the list by entering the number beside it: ";
        @array = @vio_choice4;
        $vio_selection2 = loop2(@array);
        $final_selection2 = $vio_selection2;
    }
    
    elsif ($vio_selection eq 64) {
        $start = 26;
        $end = 31;
        $line1 = line_number3($vio_selection, $count);
        print "$violation_num[$line1] $violation[$line1]\n";
        print_options3($start, $end);
        print "\n";
        print "Please select a violation from the list by entering the number beside it: ";
        @array = @vio_choice64;
        $vio_selection2 = loop2(@array);
        $final_selection2 = $vio_selection2;
    }
    
    elsif ($vio_selection eq 225) {
        $start = 32;
        $end = 36;
        $line1 = line_number3($vio_selection, $count);
        print "$violation_num[$line1] $violation[$line1]\n";
        print_options3($start, $end);
        print "\n";
        print "Please select a violation from the list by entering the number beside it: ";
        @array = @vio_choice225;
        $vio_selection2 = loop2(@array);
        $final_selection2 = $vio_selection2;
    }
    
    elsif ($vio_selection eq 148) {
        $start = 43;
        $end = 45;
        $line1 = line_number3($vio_selection, $count);
        print "$violation_num[$line1] $violation[$line1]\n";
        print_options3($start, $end);
        print "\n";
        print "Please select a violation from the list by entering the number beside it: ";
        @array = @vio_choice148;
        $vio_selection2 = loop2(@array);
        $final_selection2 = $vio_selection2;
    }
    
    elsif ($vio_selection eq 231) {
        $start = 47;
        $end = 50;
        $line1 = line_number3($vio_selection, $count);
        print "$violation_num[$line1] $violation[$line1]\n";
        print_options3($start, $end);
        print "\n";
        print "Please select a violation from the list by entering the number beside it: ";
        @array = @vio_choice231;
        $vio_selection2 = loop2(@array);
        $final_selection2 = $vio_selection2;
    }
    
    else {
        $final_selection2 = $vio_selection;
    }
    
    $vio_selection = $final_selection2;
    $line1 = line_number3($vio_selection, $count);
    
    return $final_selection2;
}

sub location_selections {
    if ($q_selection eq 4) {
        $charSelection = 2;
    }
    
    else {
        print "1.Canada\n";
        print "2.Province\n";
        print "3.City\n\n";
        print "Please select the type of location (1-3): ";
    
        $num1 = 1;
        $num2 = 3;
        $charSelection = loop($num1,$num2);
    }
    
    if ($charSelection eq '2') {
        
        for my $g (2..14) {
            print "$geoNum[$g] $geo[$g]\n";
        }
        print "\n";
        print "Please select a province: ";
        @array = @geo_choice2;
        $geo_selection = loop2(@array);
        $final_selection3 = $geo_selection;
    }
    
    elsif ($charSelection eq '1') {
        $geo_selection = $charSelection;
        $final_selection3 = $geo_selection;
    }
    
    elsif ($charSelection eq '3') {
        
        print "$geoNum[2] $geo[2]\n";
        print "$geoNum[5] $geo[5]\n";
        print "$geoNum[7] $geo[7]\n";
        print "\n";
        print "Please select which province the city belongs to: ";
        
        @array = @geo_choice3;
        $geo_selection = loop2(@array);
        
        if ($geo_selection eq 2) {
            print "$geoNum[15] $geo[15]\n";
            print "\nPlease select the city: ";
            @array = @geo_choice3_2;
            $geo_selection = loop2(@array);
        }
        elsif ($geo_selection eq 16) {
            $start = 19;
            $end = 3;
            print_options2($start, $end);
            print "\nPlease select the city: ";
            @array = @geo_choice3_16;
            $geo_selection = loop2(@array);
        }
        elsif ($geo_selection eq 7) {
            $start = 17;
            $end = 2;
            print_options2($start, $end);
            print "\nPlease select the city: ";
            @array = @geo_choice3_7;
            $geo_selection = loop2(@array);
        }
        
        $final_selection3 = $geo_selection;
    }	
    
    
    return $final_selection3;
}

sub year_selections {
    print "1. Single year\n";
    print "2. Range of years\n\n";
    
    print "Please select a time period (1 or 2): ";
    $num1 = 1;
    $num2 = 2;
    $y_selection = loop($num1,$num2);
    
    if ($y_selection eq 2) {
        
        @array = @general_select_22;
        $input = $final_selection3;
        if(in_array($input,@array)) {
            print "\nSelect the first year in the range (2006-2015): ";
            $num1 = 2006;
            $num2 = 2015;
            
            $y_start = loop($num1,$num2);
            print "\nSelect the last year in the range (2006-2015): ";
            $num1 = 2006;
            $num2 = 2015;
            $y_end = loop($num1,$num2);
        }
        
        else {
            print "\nSelect the first year in the range (1998-2015): ";
            $num1 = 1998;
            $num2 = 2015;
            
            $y_start = loop($num1,$num2);
            print "\nSelect the last year in the range (1998-2015): ";
            $num1 = 1998;
            $num2 = 2015;
            $y_end = loop($num1,$num2);
        }
        
        if ($y_start < $y_end) {
            $time_period[0] = $y_start;
            $time_period[1] = $y_end;
        }
        else {
            $time_period[1] = $y_start;
            $time_period[0] = $y_end;
        }
        if ($q_selection eq 1) {
            print "\nWhat is the $stat[$calculation]  of $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1]?\n";
        }
        elsif ($q_selection eq 2) {
            if ($general_select eq 24) {
                print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $geo[$line2] during $time_period[0]-$time_period[1]?\n";
            }
            else {
                print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during $time_period[0]-$time_period[1]?\n";
            }
        }
        elsif ($q_selection eq 3) {
            if ($general_select eq 24) {
                print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the $stat[$calculation] $stat[$line] for $geo[$line2] during $time_period[0]-$time_period[1]?\n";
            }
            elsif ($general_select eq 23 || $general_select eq 22) {
                print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during $time_period[0]-$time_period[1]?\n";
            }
        }
    }
    
    elsif ($y_selection eq 1) {
        @array = @general_select_22;
        $input = $final_selection3;
        if(in_array($input,@array)) {
            print "\nSelect a year between 2006 and 2015: ";
            $num1 = 2006;
            $num2 = 2015;
            $y_single = loop($num1,$num2);
        }
        else {
            print "\nSelect a year between 1998 and 2015: ";
            $num1 = 1998;
            $num2 = 2015;
            $y_single = loop($num1,$num2);
        }
        $time_period[0] = $y_single;
        $time_period[1] = 0;
        if ($q_selection eq 1) {
            print "What is the $stat[$calculation] of $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1]?\n";
        }
        elsif ($q_selection eq 2) {
            if ($general_select eq 24) {
                print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $geo[$line2] during $time_period[0]?\n";
            }
            else {
                print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during $time_period[0]?\n";
            }
        }
        
        elsif ($q_selection eq 3) {
            if ($general_select eq 24) {
                print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the $stat[$calculation] of $stat[$line] for $geo[$line2] during $time_period[0]?\n";	
            }
            elsif ($general_select eq 23 || $general_select eq 22) {
                print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during $time_period[0]?\n";
            }
        }
    }
    
    return @time_period;
}

#
#   Question Input subroutines
#

sub question1 {
    print "\nWhat is the ______ ...?\n\n";
    for my $n(15..18) {
        print "$statNum[$n] $stat[$n]\n";
    }
    
    print "\nPlease selcect one of the options by entering a number (15-18): ";
    $num1 = 15;
    $num2 = 18;
    $calculation = loop($num1,$num2);
    
    print "\nWhat is the $stat[$calculation] _______ ...?\n\n";
    stats_selections();
    
    $count = $record_count;
    $line = line_number($final_selection, $count);
    
    print "\nWhat is the $stat[$calculation] $stat[$line] for ________ ...?\n\n";
    
    $count = $record_count3;
    
    violation_selections();
    
    print "\nWhat is the $stat[$calculation] $stat[$line] for $violation[$line1] in ______ ...?\n\n";
    
    location_selections();
    $count = $record_count2;
    $geo_selection = $final_selection3;
    $line2 = line_number2($geo_selection, $count);
    
    print "\nWhat is the $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during ____ ...?\n\n";
    
    year_selections();
    
    #location.violation.statistic
    $data_encoding = "$final_selection3.$final_selection2.$final_selection";

    answerQ1();
}

sub question2 {
    print "\nWhich ______ ...?\n";
    for my $n(22..24) {
        print "$statNum[$n] $stat[$n]\n";
    }
    print "\nPlease selcect one of the options by entering a number (22-24): ";
    
    $num1 = 22;
    $num2 = 24;
    $general_select = loop($num1,$num2);
    
    print "Which $stat[$general_select] has the _____ ..?\n";
    for my $n(15..16) {
        print "$statNum[$n] $stat[$n]\n";
    }
    print "\nPlease selcect one of the options by entering a number: ";
    
    $num1 = 15;
    $num2 = 16;
    $calculation = loop($num1,$num2);
    print "Which $stat[$general_select] has the $stat[$calculation] _______ ..?\n";
    stats_selections();
    
    $count = $record_count;
    $line = line_number($final_selection, $count);
    
    print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for ______..?\n";
    
    if ($general_select eq 22) {
        $count = $record_count3;
        violation_selections();
        print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during _____?\n";
        $final_selection3 = 3;
        
        year_selections();
        
        $data_encoding = "city.$final_selection2.$final_selection";
    }
    if ($general_select eq 23) {
        $count = $record_count3;
        violation_selections();
        print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during _____?\n";
        
        $final_selection3 = $stat[$general_select];
        year_selections();
        $data_encoding = "$final_selection3.$final_selection2.$final_selection";
    }
    elsif ($general_select eq 24) {
        location_selections();
        $count = $record_count2;
        $geo_selection = $final_selection3;
        $line2 = line_number2($geo_selection, $count);
        print "Which $stat[$general_select] has the $stat[$calculation] of $stat[$line] for $geo[$line2] during _____?\n";
        year_selections();
        $final_selection2 = $stat[$general_select];
        $data_encoding = "$final_selection3.$final_selection2.$final_selection";
        
    }
    
    answerQ2();
}

sub question3 {
    print "\nWhich ______ ...?\n";
    for my $n(23..24) {
        print "$statNum[$n] $stat[$n]\n";
    }
    print "\nPlease select one of the options by entering a number (23-24): ";
    
    $num1 = 23;
    $num2 = 24;
    $general_select = loop($num1,$num2);
    
    print "\nWhich $stat[$general_select];______  or _______...?\n";
    if ($general_select eq 24) {
        $count = $record_count3;
        $final_selection2_1 = violation_selections();
        print "final selection $final_selection2\n";
        $lineNum2 = $line1;
        print "\nWhich $stat[$general_select]; $violation[$line1] or _______...?\n";
        $count = $record_count3;
        $final_selection2_2 = violation_selections();
        print "final selection 2 $final_selection2_2\n";
        
        $count = $record_count3;
        $lineNum = line_number3($final_selection2_2, $count);
        
        print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the ______...?\n";
        
        for my $n(15..16) {
            print "$statNum[$n] $stat[$n]\n";
        }
        print "\nPlease selcect one of the options by entering a number: ";
        $num1 = 15;
        $num2 = 16;
        $calculation = loop($num1,$num2);
        print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the $stat[$calculation] _________...?\n";
        
        stats_selections();
        $count = $record_count;
        
        $line = line_number($final_selection, $count);
        print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the $stat[$calculation] of $stat[$line] for _______...?\n";
        
        location_selections();
        $count = $record_count2;
        $geo_selection = $final_selection3;
        $line2 = line_number2($geo_selection, $count);
        
        print "\nWhich $stat[$general_select]; $violation[$lineNum2] or $violation[$lineNum] has the $stat[$calculation] of $stat[$line] for $geo[$line2] during ...?\n";
        
        year_selections();
        
        $data_encoding = "$final_selection3.$final_selection2_1.$final_selection";
        $data_encoding2 = "$final_selection3.$final_selection2_2.$final_selection";
    }
    
    if ($general_select eq 23) {
        location_selections();
        $count = $record_count2;
        $geo_selection = $final_selection3;
        $line2 = line_number2($geo_selection, $count);
        
        $lineNum2 = $line2;
        $final_selection2_1 = $final_selection3;
        
        print "\nWhich $stat[$general_select]; $geo[$lineNum2] or _______...?\n";
        
        location_selections();
        $count = $record_count2;
        $geo_selection = $final_selection3;
        $line2 = line_number2($geo_selection, $count);
        
        $lineNum = $line2;
        
        $final_selection2_2 = $final_selection3;
        
        print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the ...?\n";
        
        for my $n(15..16) {
            print "$statNum[$n] $stat[$n]\n";
        }
        print "\nPlease selcect one of the options by entering a number: ";
        $num1 = 15;
        $num2 = 16;
        $calculation = loop($num1,$num2);
        print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the $stat[$calculation] _________...?\n";
        
        stats_selections();
        $count = $record_count;
        
        $line = line_number($final_selection, $count);
        
        print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the $stat[$calculation] of $stat[$line] for _______...?\n";
        
        $count = $record_count3;
        violation_selections();
        
        print "\nWhich $stat[$general_select]; $geo[$lineNum2] or $geo[$lineNum] has the $stat[$calculation] of $stat[$line] for $violation[$line1] during ____...?\n";
        
        year_selections();
        
        $data_encoding = "$final_selection2_1.$final_selection2.$final_selection";
        $data_encoding2 = "$final_selection2_2.$final_selection2.$final_selection";
        
    }
    answerQ3();
    
}

sub question4 {
    
    print "\nWhat is the contribution of the population of _________ ...?\n";
    
    location_selections();
    
    $count = $record_count2;
    $geo_selection = $final_selection3;
    $line2 = line_number2($geo_selection, $count);
    
    print "\nWhat is the contribution of the population of $geo[$line2] to the total incidents of _______ in 2011?\n";
    
    $count = $record_count3;
    violation_selections();
    
    print "\nWhat is the contribution of the population of $geo[$line2] to the total incidents of $violation[$line1] in 2011?\n";
    
    $time_period[0] = 2011;
    $time_period[1] = 0;
    
    answerQ4();
    
}

#
#   Main subroutine calls and exit loops
#

do {
    printMenu();
    print "Question selection: ";
    
    $num1 = 1;
    $num2 = 4;
    $q_selection = loop($num1,$num2);
    if ($q_selection eq 1) {
        question1 ();
    }
    elsif ($q_selection eq 2) {
        question2 ();
    }
    elsif ($q_selection eq 3) {
        question3 ();
    }
    elsif ($q_selection eq 4) {
        question4 ();
    }
    
    if ($q_selection ne 4 && $q_selection ne 2) {
        do {
            print "Do you wish to graph your answer? (1)Yes, (0)No\n";
            $num1 = 0;
            $num2 = 1;
            $graph = loop($num1,$num2);
            
            if ($graph == 1) {
                print "How would you like to graph it? (1)line, (2)scatter, (3)bar\n";
                $num1 = 1;
                $num2 = 3;
                $graph_type = loop($num1,$num2);
                if ($graph_type == 1) {
                    $command = "perl line.pl datapoints.txt";
                }
                elsif ($graph_type == 2) {
                    $command = "perl scatter.pl datapoints.txt";
                }
                elsif ($graph_type == 3) {
                    $command = "perl bar.pl datapoints.txt";
                }
                system($command);
            }
        } while ($graph == 1);
    }
    
    elsif ($q_selection eq 4) {
        print "Do you wish to graph your answer? (1)Yes, (0)No\n";
        $num1 = 0;
        $num2 = 1;
        $graph = loop($num1,$num2);
        if ($graph == 1) {
            $command = "perl bar2.pl datapoints.txt";
            system($command);
        }
    }
    elsif ($q_selection eq 2) {
        do {
            print "Do you wish to graph your answer? (1)Yes, (0)No\n";
            $num1 = 0;
            $num2 = 1;
            $graph = loop($num1,$num2);
            
            if ($graph == 1) {
                print "How would you like to graph it? (1)line, (2)bar\n";
                $num1 = 1;
                $num2 = 2;
                $graph_type = loop($num1,$num2);
                if ($graph_type == 1) {
                    $command = "perl line.pl datapoints.txt";
                }
                elsif ($graph_type == 2) {
                    $command = "perl bar.pl datapoints.txt";
                }
                system($command);
            }
        } while ($graph == 1);

    }
    
    print "Do you wish to ask another question? (1)Yes, (0)No\n";
    $num1 = 0;
    $num2 = 1;
    $quit = loop($num1,$num2);
    
} while ( $quit == 1 );

print "Goodbye!\n";


#
#   Data Gathering, Writing, and Calculations Subroutines
#

sub searchArray {
    
    my @array = ();
    my $coord = $_[0];
    my $value_cnt = 0;
    my $year_incr = 0;
    my $j = 0;

    foreach $j ( 0..$crime_record_cnt ) {
        
        if ($coord eq $coordinate_crime[$j]) {
            
            #if searching for a single year
            
            if ( $time_period[1] == 0 ) {
                if ($date_crime[$j] == $time_period[0]) {
                    if ($value_crime[$j] ne "..") {
                        $array[0][0] = $value_crime[$j];
                        $array[0][1] = $j;
                    }
                }
            }#if single year
            
            # if searching for a range of years
            else {
                
                #if date is equal to initial date or later and less or equal to ending date
                if ( $date_crime[$j] == ( $time_period[0] + $year_incr ) && $date_crime[$j] <= $time_period[1] ) {
                    #if value not undefined store it in array
                    if ($value_crime[$j] ne "..") {
                        $array[$value_cnt][0] = $value_crime[$j];
                        $array[$value_cnt][1] = $j;
                        $value_cnt++;
                    }
                    $year_incr++;
                }
            }#else range of years
            
        }#if coord
    }#for
    
    return @array;
}

sub searchCensusArray {
    
    my @array = ();
    my $prov = $_[0];
    
    foreach my $k ( 0..$census_record_cnt ) {
        if ( $prov == $geocode_census[$k] ) {
            $array[0][0] = $total_census[$k];
            $array[0][1] = $k;
            last;
        }
    }
    
    return @array;
    
}

sub printFoundData {
    my @array = @_;
    print "\nFound Entries:\n";
    for (my $i = 0; $i <= $#array; $i++) {
        print "$violation_crime[$array[$i][1]], $STA_crime[$array[$i][1]] in $geocode_crime[$array[$i][1]] in $date_crime[$array[$i][1]]: $array[$i][0]\n";
    }
    print "\n";
}

sub writeToFile {
    my @array = @_;
    #   Writing found data to file
    open ( my $fh, '>', $write_filename ) or die "Could not open file '$write_filename\n";
    print $fh "\"Year\",\"Value\",\"Name\"\n";
    foreach my $i (0..$#array) {
        print $fh "$date_crime[$array[$i][1]],$array[$i][0],$geocode_crime[$array[$i][1]]\n";
    }
    close $fh;
}

#return index of the highest value
sub highest {
    my @unsorted = @_;
    my @sorted;
    
    if ($#unsorted != -1) {
        @sorted = sort { $a->[0] <=> $b->[0] } @unsorted;
        
        return $sorted[$#sorted][1];
    }
    else {
        return -1;
    }
}

#return index of the lowest value
sub lowest {
    my @unsorted = @_;
    my @sorted;
    
    if ($#unsorted != -1) {
        @sorted = sort { $a->[0] <=> $b->[0] } @unsorted;
        
        return $sorted[0][1];
    }
    else {
        return -1;
    }
}

#returns the average of the values
sub average {
    my @array = @_;
    my $sum = 0;
    
    if ($#array != -1) {
        for (my $i = 0; $i < ($#array + 1); $i++) {
            $sum = $sum + $array[$i][0];
        }
        
        return ($sum / ($#array + 1));
    }
    else {
        return -1;
    }
}

# sorts the array of values and returns array
sub top {
    my @unsorted = @_;
    my @sorted = ();
    
    if ($#unsorted != -1) {
        @sorted = sort { $b->[0] <=> $a->[0] } @unsorted;
    }
    return @sorted;
}

#
#   Question algorithms
#

sub answerQ1 {
    
    my $list = 0;
    
    @found_data = searchArray($data_encoding);
    printFoundData(@found_data);
    writeToFile(@found_data);

    if ( $calculation == 15 ) {
        $answer = highest(@found_data);
        
        if ($time_period[1] != 0 ) {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1] is $value_crime[$answer] in $date_crime[$answer]\n\n";
        }
        else {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0] is $value_crime[$answer] in $date_crime[$answer]\n\n";
        }
        
    }
    elsif ( $calculation == 16 ) {
        $answer = lowest(@found_data);
        
        if ($time_period[1] != 0 ) {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1] is $value_crime[$answer] in $date_crime[$answer]\n\n";
        }
        else {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0] is $value_crime[$answer] in $date_crime[$answer]\n\n";
        }
    }
    elsif ( $calculation == 17 ) {
        $answer = average(@found_data);
        
        if ($time_period[1] != 0 ) {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1] ";
            print "is ";
            printf ("%.2f",$answer);
            print "\n\n";
        }
        else {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0] ";
            print "is ";
            printf ("%.2f",$answer);
            print "\n\n";
        }

    }
    elsif ( $calculation == 18 ) {
        @top_values = top(@found_data);
        
        if ($time_period[1] != 0) {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0]-$time_period[1] is:\n";
            for (my $i = 0; $i <= $#top_values && $i < 10; $i++) {
                $list = $i + 1;
                print "$list. $top_values[$i][0] in $date_crime[$top_values[$i][1]]\n";
            }
            print "\n";
        }
        else {
            print "\nThe $stat[$calculation] $stat[$line] for $violation[$line1] in $geo[$line2] during $time_period[0] is:\n";
            for (my $i = 0; $i <= $#top_values && $i < 10; $i++) {
                $list = $i + 1;
                print "$list. $top_values[$i][0] in $date_crime[$top_values[$i][1]]\n";
            }
            print "\n";
        }
        
    }
}

sub answerQ2 {
    
    @found_data = ();
    @found_data2 = ();
    
    # if the user wants citites
    if ($general_select eq 22) {
        for (my $i = 0; $i < $#general_select_22; $i++) {
            $data_encoding = "$general_select_22[$i].$final_selection2.$final_selection";
            @found_data2 = searchArray($data_encoding);
            for (my $i = 0; $i <= $#found_data2; $i++) {
                push @found_data, $found_data2[$i];
            }
        }
        writeToFile(@found_data);
    }
    
    # if the user wants provinces
    if ($general_select eq 23) {
        for (my $i = 0; $i < $#geo_choice2; $i++) {
            $data_encoding = "$geo_choice2[$i].$final_selection2.$final_selection";
            @found_data2 = searchArray($data_encoding);
            
            for (my $i = 0; $i <= $#found_data2; $i++) {
                push @found_data, $found_data2[$i];
            }

        }
        writeToFile(@found_data);
    }
    
    # if the user wants violation
    if ($general_select eq 24) {
        for (my $i = 0; $i <= $#all_violations; $i++) {
            $data_encoding = "$final_selection3.$all_violations[$i].$final_selection";
            @found_data2 = searchArray($data_encoding);
            
            for (my $i = 0; $i < $#found_data2; $i++) {
                push @found_data, $found_data2[$i];
            }

        }
        #   Writing found data and violation names to file
        open ( my $fh, '>', $write_filename ) or die "Could not open file '$write_filename\n";
        print $fh "\"Year\",\"Value\",\"Name\"\n";
        foreach my $i (0..$#found_data) {
            print $fh "$date_crime[$found_data[$i][1]],$found_data[$i][0],$violation_crime[$found_data[$i][1]]\n";
        }
        close $fh;
    }
    
    printFoundData(@found_data);
    
    
    if ( $calculation == 15 ) {
        $answer = highest(@found_data);
    }
    elsif ( $calculation == 16 ) {
        $answer = lowest(@found_data);
    }
    
    # chose between city and provinces
    if ( $general_select == 22 || $general_select == 23 ) {
        if ($time_period[1] != 0 ) {
            print "$geocode_crime[$answer] has the $stat[$calculation] for $violation[$line1] during $time_period[0]-$time_period[1] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        else {
            print "$geocode_crime[$answer] has the $stat[$calculation] for $violation[$line1] during $time_period[0] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
    }
    
    # chose between violations
    if ( $general_select == 24 ) {
        if ($time_period[1] != 0 ) {
            print "$violation_crime[$answer] has the $stat[$calculation] for $geocode_crime[$answer] during $time_period[0]-$time_period[1] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        else {
            print "$violation_crime[$answer] has the $stat[$calculation] for $geocode_crime[$answer] during $time_period[0] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
    }
    print "\n";
}

sub answerQ3 {
    
    @found_data = ();
    @found_data2 = ();
    
    @found_data = searchArray($data_encoding);
    @found_data2 = searchArray($data_encoding2);
    
    for (my $i = 0; $i <= $#found_data2; $i++) {
        push @found_data, $found_data2[$i];
    }
    
    printFoundData(@found_data);
    
    if ( $calculation == 15 ) {
        $answer = highest(@found_data);
    }
    elsif ( $calculation == 16 ) {
        $answer = lowest(@found_data);
    }

    #chose between locations
    if ( $general_select == 23 ) {
        if ($time_period[1] != 0 ) {
            print "Between $geocode_crime[$found_data[0][1]] and $geocode_crime[$found_data[$#found_data][1]], $geocode_crime[$answer] has the $stat[$calculation] for $violation[$line1] during $time_period[0]-$time_period[1] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        else {
            print "Between $geocode_crime[$found_data[0][1]] and $geocode_crime[$found_data[$#found_data][1]], $geocode_crime[$answer] has the $stat[$calculation] for $violation[$line1] during $time_period[0] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        
        writeToFile(@found_data);

    }
        
    #chose between violations
    if ( $general_select == 24 ) {
        if ($time_period[1] != 0 ) {
            print "Between $violation[$lineNum] and $violation[$lineNum2], $violation_crime[$answer] has the $stat[$calculation] for $geocode_crime[$answer] during $time_period[0]-$time_period[1] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        else {
            print "Between $violation[$lineNum] and $violation[$lineNum2], $violation_crime[$answer] has the $stat[$calculation] for $geocode_crime[$answer] during $time_period[0] at $value_crime[$answer] in $date_crime[$answer]\n";
        }
        
        #   Writing found data and violation names to file
        open ( my $fh, '>', $write_filename ) or die "Could not open file '$write_filename\n";
        print $fh "\"Year\",\"Value\",\"Name\"\n";
        foreach my $i (0..$#found_data) {
            print $fh "$date_crime[$found_data[$i][1]],$found_data[$i][0],$violation_crime[$found_data[$i][1]]\n";
        }
        close $fh;
    }
    print "\n";
}

sub answerQ4 {
    
    my $temp_province;
    
    #location.violation.ACTUALINCIDENTS
    $data_encoding = "$final_selection3.$final_selection2.1";
    @found_data = searchArray($data_encoding);
    printFoundData(@found_data);
    
    foreach my $k (0..$#geo_choice2) {
        if ($final_selection3 eq $geo_choice2[$k]) {
            $temp_province = $k;
        }
    }
    
    my $prov_num = $census_provinces[$temp_province];
    
    my @census_data = searchCensusArray($prov_num);
    
    print "The $characteristic_census[$census_data[0][1]] of $prov_name_census[$census_data[0][1]] in $date_crime[$found_data[0][1]] is $census_data[0][0]\n\n";
    
    #   Writing found data and population to file
    open ( my $fh, '>', $write_filename ) or die "Could not open file '$write_filename\n";
    print $fh "\"Year\",\"Value\",\"Name\"\n";
    print $fh "$date_crime[$found_data[0][1]],$found_data[0][0],$violation_crime[$found_data[0][1]]\n";
    print $fh "$date_crime[$found_data[0][1]], $census_data[0][0], $characteristic_census[$census_data[0][1]]\n";
    close $fh;

    
}

#
#   End of Script
#

