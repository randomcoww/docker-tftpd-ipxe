FROM alpine:latest

RUN set -x \
  \
  && apk add --no-cache tftp-hpa \
  && mkdir /tftp \
  && chown nobody:nobody /tftp

ADD --chown=nobody http://boot.ipxe.org/ipxe.efi /tftp

ENTRYPOINT ["in.tftpd"]
CMD ["--foreground", "--user", "nobody", "--address", "0.0.0.0:69", "--verbose", "--secure", "/tftp"]
