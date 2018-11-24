#!/bin/sh

## start
exec in.tftpd "$@" \
  --foreground \
  --user nobody \
  --secure "$TFTP_PATH" \
