#!/usr/bin/perl -w
##############
# client
##############
use strict;
use warnings;
use IO::Socket::INET;

$| = 1;         # for autoflush

#my $ip =    "127.0.0.1";
my $ip =    "192.168.0.201";
my $port =  "9999";
my  $command = "";

if( $#ARGV == -1 ) {                # Case: No command/argument
    print "No command requested.\n";
    &usage;
    exit -1;
}
elsif($#ARGV >= 1){                 # Case: more then one command/arguments
    print "To much agruments.\n";
    &usage;
    exit -1;
}
elsif($#ARGV == 0){                 # Case: One command/argument
    $command = $ARGV[0]."\n";
    #print "\n-->$command<--\n";
    #print "Client requested command: $command\n";

    # create a connecting socket
    my $socket = IO::Socket::INET->new (
        PeerAddr => $ip,
        PeerPort => $port,
        Proto => 'tcp',
        #Listen    => 1
        Type     => SOCK_STREAM
    ) or die "Can't create socket $!\n";

    
    if($command!~/^rm/){             # requested command contains no "rm"
        # Send command to server
        $socket->send ($command);
        
        # receive answer from server until "end of command"
        while ((my $answer = <$socket>) ne "EOC\n")
        {
            print $answer;
        }
    }
    else {
        print "Sorry, got no command or not allowed...\n";
    }
}
else{                               # Case: helpless error...
    print "What the hell did you request??!?!!!\n";
}

###########################################################
# Subs come here...
#
# Output: Prints the usage of that script.
sub usage() {

    print "\nUsage:\n";
    print "\n\tclient_TCP.pl [one COMMAND]\n";
    print "\n\te.g.: client_TCP.pl \"ls -l\"\n\n";
    print "Good by...\n\n";
}

