This script invokes tcpdump over ssh piping to STDOUT, allowing remote use of wireshark. 

The $TCPDUMPFILTER variable should be defined to either match the traffic you're interested in, or discard your SSH traffic.

Failure to define $TCPDUMPFILTER results in exponential traffic growth, so there is logic to make sure it is not null.
