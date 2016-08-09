FROM debian:sid

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update -qq && \
  apt-get install --no-install-recommends -qqy tftpd-hpa && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/*

ADD http://boot.ipxe.org/undionly.kpxe /srv/tftp
ADD http://boot.ipxe.org/ipxe.efi /srv/tftp

EXPOSE 69/udp

ENTRYPOINT ["/usr/sbin/in.tftpd"]
CMD ["--listen", "--user", "nobody", "--address", "0.0.0.0:69", "--verbose", "--secure", "--foreground", "/srv/tftp"]
