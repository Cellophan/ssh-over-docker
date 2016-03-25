# ssh-over-docker
If you can run docker, you can ssh to the machine. This is a PoC :)

To start your socks proxy:
    ssh -CD 1080 -o ProxyCommand="docker run --rm -i --name sshd cell/ssh-over-docker $(cat ~/.ssh/id_rsa.pub)" root@127.0.0.1
