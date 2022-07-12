#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $debug=0;

# save arguments following -w or --word in the scalar
# =s means that an argument follows
GetOptions( 'action=s' => \my $action, 'content=s' => \my $content);

if($debug==1){
    print "$action - $content\n";
}

my $todofile = 'todo.txt';
if($action eq 'create'){
    open(my $livefile, '>>:encoding(UTF-8)', $todofile) or die "Could not open todofile '$todofile'";
    print $livefile "[ ] $content\n";
    print "recorded $content to todo-list\n";
    close $livefile;
}
elsif($action eq 'list'){
    open(my $livefile, '<:encoding(UTF-8)', $todofile) or die "Could not open todofile '$todofile'";
    while(my $row = <$livefile>){
        chomp $row; # removes trailing new line
        print "$row \n";
    }
    print "End of list\n";
    close $livefile;
}
