#!/bin/bash

stacktrace () {
	echo "FAIL: unhandled error. stacktrace:"
	i=0
	while caller $i; do
		i=$((i+1))
	done
}

set -Eeuo pipefail
trap "stacktrace" ERR

if [ -z "${1}" ]; then
	echo 'Give Authorized key as args.'

	echo -e 'Example of command line:
	ssh -CD 1080 -o ProxyCommand="docker run --rm -i cell/ssh-over-docker $(cat ~/.ssh/id_rsa.pub)" root@127.0.0.1'
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
/usr/sbin/sshd -E /var/log/sshd.log

sleep 1
nc 127.0.0.1 22

