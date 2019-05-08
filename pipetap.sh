#!/usr/bin/env bash
# Written by Shadow
main () {
	local TCPDumpFilter="ip host not $(dig +short myip.opendns.com @resolver1.opendns.com) and not tcp port 22"

	if [[ ${#} -ne 2 ]]; then
		cat << 'EOF'
This script invokes tcpdump over ssh piping to STDOUT, allowing remote use of wireshark
Script invocation: $0 user@<ip> <interface|ANY>
TCPDUMPFILTER variable must be set in the script to avoid exponential traffic over ssh
EOF
        	exit 1
	fi
	if [[ -z "$TCPDumpFilter" ]]; then
        	TCPDumpFilter="ip host not $(dig +short myip.opendns.com @resolver1.opendns.com) and not tcp port 22"
	fi
	ssh -C "${1}" tcpdump -s 0 -i "${2}" -w - $TCPDumpFilter | wireshark -k -i -
}

main "${@}"
exit 0
