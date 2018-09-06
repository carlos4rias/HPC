#!/bin/bash

main() {
	repositories_go
	update_go
	tools_go
	autoremove_go
}

repositories_go() {
	echo "NOOP"
}

update_go() {
	# Update the server
	apt-get update
	apt-get dist-upgrade -y 
}

autoremove_go() {
	apt-get -y autoremove
}

tools_go() {
	# Install basic tools
	apt-get -y install build-essential binutils-doc git subversion mpic++ g++ gcc 
}

main
exit 0


