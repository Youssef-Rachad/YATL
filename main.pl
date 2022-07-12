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
    while(my $line = <$livefile>){ # <> used for files and globs
        chomp $line; # removes trailing new line
        print "$line \n";
    }
    print "End of list\n";
    close $livefile;
}
elsif ($action eq 'mark'){
    # check that we are given a positive integer index
    if($content =~ /^\D+$/){die "Must provide integer argument, got $content";}
    open(my $livefile, '<:encoding(UTF-8)', $todofile) or die "Could not open todofile '$todofile'";
    my @todos;
    while(my $todo = <$livefile>){
        if($todo =~ /\>/){
            push @todos, (split(/\s/, $todo))[0]."\n";
        }else{
            push @todos, $todo;
        }
    }
    close $livefile;
    if($content > scalar @todos){
        die "Index provided ($content) exceeds todo-list length (".scalar @todos.")";
    }
    $todos[$content] =~ s/\[ \]/[x]/;
    open($livefile, '>:encoding(UTF-8)', $todofile) or die "Could not open todofile '$todofile'";
    print $livefile @todos;
    close $livefile;
    print @todos;
}
