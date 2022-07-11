use Getopt::Long;

# save arguments following -w or --word in the scalar
# =s means that an argument follows
GetOptions( 'action=s' => \my $action,
            'content=s' => \my $content
        );

echo $action;
