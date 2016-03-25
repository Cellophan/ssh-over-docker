#!/bin/bash

set -e

if [ -z "${1}" ]; then
	echo "Give Authorized key as args."
	echo "DEBUG Arg:$@"
	exit 1
fi

#Generating keys...
ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key >/dev/null
ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key >/dev/null
ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key >/dev/null
ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key >/dev/null

#Add authorized key: ${@}
mkdir /root/.ssh
echo ${@} >/root/.ssh/authorized_keys

#Starting sshd
/usr/sbin/sshd

nc 127.0.0.1 22
