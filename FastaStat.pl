#!/usr/bin/env perl -w 
# USAGE: FastaStat.pl {FASTA file} Output: # Sequences
#	  # Average length of a sequence Sum of lengths of all sequences Empty sequences
# 	# Longest/shortest length of a sequence

use strict; if( exists $ARGV[0] ) {
    my $n_seq=0;
    my $tot_len=0;
    my $empty_seq=0;
    my $this_len=0;
    my $flag_empty=0;
    my $shortest=0;
    my $longest=0;
    my $whichlongest=-1;
    my $fahead="";
    
    open(Ffile,"$ARGV[0]");
    while(<Ffile>) {
         chomp;
         if(/>/) {
   		if($flag_empty==1) {
			$empty_seq++;
		}
		$tot_len=$tot_len+$this_len;
		if($n_seq==1) {
			$shortest=$this_len;
			$longest=$this_len;
			$whichlongest=$fahead;
  		}
		if($n_seq>1) {
			if($shortest>$this_len) {
				$shortest=$this_len;
			}
			if($longest<$this_len) {
				$longest=$this_len;
				$whichlongest=$fahead;
			}
  		}
		$n_seq++;
                $fahead=$_;
    		$this_len=0;
		$flag_empty=1;
                next;
         }
         if($_ ne "") {
		$flag_empty=0;
		$this_len=$this_len+length;
         }
    } #end while
    $tot_len=$tot_len+$this_len;
    if($flag_empty==1) {
	$empty_seq++;
    }
    if($n_seq==1) {
	$shortest=$this_len;
	$longest=$this_len;
				$whichlongest=$fahead;
    }
    if($n_seq>1) {
	if($shortest>$this_len) {
    		$shortest=$this_len;
 	}
	if($longest<$this_len) {
		$longest=$this_len;
				$whichlongest=$fahead;
	}
    }
    my $avg_len=$tot_len/$n_seq;
    print "Report for the FASTA file $ARGV[0]: \n";
    print " Number of sequences = $n_seq\n";
    print " Total length = $tot_len\n";
    print " Average length of sequences = $avg_len\n";
    print " Number of empty sequences = $empty_seq\n";
    print " Longest length of a sequence = $longest\n $whichlongest\n";
    print " Shortest length of a sequence = $shortest\n";
}
else {
	print "#USAGE: FastaStat.pl {FASTA file}\n";
}
