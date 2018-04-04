FROM alpine:latest as BUILD

RUN set -x \
  \
  && apk add --no-cache \
    g++ \
    xz-dev \
    make \
    perl \
    bash \
    cdrkit \
    git \
  \
  && mkdir -p /usr/src \
  && git clone https://git.ipxe.org/ipxe.git /usr/src/ipxe

WORKDIR /usr/src/ipxe/src
COPY config/ config/local/

RUN set -x \
  \
  && make -j "$(getconf _NPROCESSORS_ONLN)" \
    bin-x86_64-efi/ipxe.efi \
    bin/undionly.kpxe \
    bin/ipxe.lkrn


FROM alpine:latest

ENV TFTP_PATH /var/tftpboot

COPY --from=BUILD /usr/src/ipxe/src/bin-x86_64-efi/ipxe.efi $TFTP_PATH/ipxe.efi
COPY --from=BUILD /usr/src/ipxe/src/bin/undionly.kpxe       $TFTP_PATH/undionly.kpxe
COPY --from=BUILD /usr/src/ipxe/src/bin/ipxe.lkrn           $TFTP_PATH/ipxe.lkrn

RUN set -x \
  \
  && apk add --no-cache tftp-hpa \
  \
  && chown -R nobody:nobody $TFTP_PATH \
  && chmod +r $TFTP_PATH/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
