FROM alpine

RUN apk add --update bash openssh
COPY start.sh /

ENTRYPOINT ["/start.sh"]

