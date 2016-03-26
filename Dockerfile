FROM alpine
MAINTAINER Cell <maintainer.docker.cell@outer.systems>

RUN apk add --update bash openssh
COPY start.sh /

ENTRYPOINT ["/start.sh"]

