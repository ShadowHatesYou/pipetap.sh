#!/bin/bash
# Written by Shadow
TCPDUMPFILTER="ip host not $(dig +short myip.opendns.com @resolver1.opendns.com) and not tcp port 22"

if [ $# != 2 ]; then
        echo -e "This script invokes tcpdump over ssh piping to STDOUT, allowing remote use of wireshark"
        echo -e "Script invocation: $0 user@<ip> <interface|ANY>"
	echo -e "TCPDUMPFILTER variable must be set in the script to avoid exponential traffic over ssh"
        exit
fi
if [ -z "$TCPDUMPFILTER" ]; then
        TCPDUMPFILTER="ip host not $(dig +short myip.opendns.com @resolver1.opendns.com) and not tcp port 22"
fi
ssh -C $1 tcpdump -s 0 -i $2 -w - $TCPDUMPFILTER | wireshark -k -i -
