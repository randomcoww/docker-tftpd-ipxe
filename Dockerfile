FROM alpine:latest

ENV TFTP_PATH /var/tftp

RUN set -x \
  \
  && apk add --no-cache tftp-hpa \
  \
  && mkdir $TFTP_PATH \
  && wget -O $TFTP_PATH/ipxe.efi http://boot.ipxe.org/ipxe.efi \
  && wget -O $TFTP_PATH/undionly.kpxe http://boot.ipxe.org/undionly.kpxe \
  && chown -R nobody:nobody $TFTP_PATH \
  && chmod +r $TFTP_PATH/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
