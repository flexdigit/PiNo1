#!/usr/bin/perl -w
##############
# server
##############
use strict;
use warnings;
use IO::Socket::INET;

$| = 1;         # for autoflush

my $port =  "9999";
my $output = "";

my $socket = IO::Socket::INET->new (
    LocalPort => $port,
    Listen    => 1,
    Reuse     => 1  # erlaubt sofortige Wiederverwendung des Ports,
                    # wenn der Client "aufgelegt" hat
) or die "Can't create socket:\n$!\n$@\n";

print &printdate."Server is started and listening on port $port...\n";

while (my $client = $socket->accept) {
    # Server receives data from client
    my $line = <$client>;
    #$line = <$client>;
    
    #print $client->peerhost(), ":", $client->peerport(), "\n";
    
    # Server execute the supposed command and
    # store the output of the command in $output.
    $output = eval "qx($line)";
    
    # Error case: Wrong request !!!
    if($? == -1){
        print &printdate."Wrong request !!!  ".$line;
        $output = "Wrong request !!!\n";
    }
    # Good case
    else {
        print &printdate."Client ".$client->peerhost(). ":". $client->peerport().
              " request: ".$line;
    }
    
    # send output to client with "end of command".
    $client->send ($output."EOC\n");
}

###########################################################
# Subs come here...
#
# Output: e.g [2013-12-12 | 07:39:04]
sub printdate() {

    my $date = `date "+%F | %T"`;
    chomp $date;
    $date = "[".$date."] ";

}

