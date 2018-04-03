FROM alpine:latest

ENV TFTP_PATH /var/tftpboot

COPY ipxe-x86_64.efi $TFTP_PATH/ipxe.efi
COPY undionly.kpxe $TFTP_PATH/undionly.kpxe

RUN set -x \
  \
  && apk add --no-cache tftp-hpa \
  \
  && chown -R nobody:nobody $TFTP_PATH \
  && chmod +r $TFTP_PATH/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
