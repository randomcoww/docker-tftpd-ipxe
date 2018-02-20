FROM alpine:latest

## does not work on dockerhub yet
# ADD --chown=nobody http://boot.ipxe.org/ipxe.efi /tftp
ADD http://boot.ipxe.org/ipxe.efi /tftp
ADD http://boot.ipxe.org/undionly.kpxe /tftp

RUN set -x \
  \
  && apk add --no-cache tftp-hpa \
  && chown -R nobody:nobody /tftp

ENTRYPOINT ["in.tftpd"]
CMD ["--foreground", "--user", "nobody", "--address", "0.0.0.0:69", "--verbose", "--secure", "/tftp"]
