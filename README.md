### PXE images served over TFTP

ipxe.efi and undionly.kpxe served over TFTP-HPA

PXE images built to support:

```
DNS
HTTP
HTTPS
iSCSI
NFS
TFTP
FCoE
SRP
VLAN
AoE
EFI
Menu
```

### Image build

```
mkdir -p build
export TMPDIR=$(pwd)/build

VERSION=master

podman build \
  --build-arg VERSION=$VERSION \
  -f Dockerfile \
  -t ghcr.io/randomcoww/tftpd-ipxe:$VERSION
```

```
podman push ghcr.io/randomcoww/tftpd-ipxe:$VERSION