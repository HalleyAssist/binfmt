#!/usr/bin/env sh

set -e

: "${QEMU_TARGETS=}"

arch="$(xx-info arch)"

if [ -z "$QEMU_TARGETS" ]; then
  if [ "$arch" != "amd64" ]; then
    QEMU_TARGETS="$QEMU_TARGETS x86_64-linux-user"
  fi
  if [ "$arch" != "arm" ]; then
    QEMU_TARGETS="$QEMU_TARGETS arm-linux-user"
  fi
fi

set -x
./configure \
  --prefix=/usr \
  --with-pkgversion=$QEMU_VERSION \
  --enable-linux-user \
  --disable-system \
  --static \
  --disable-brlapi \
  --disable-cap-ng \
  --disable-capstone \
  --disable-curl \
  --disable-curses \
  --disable-docs \
  --disable-gcrypt \
  --disable-gnutls \
  --disable-gtk \
  --disable-guest-agent \
  --disable-guest-agent-msi \
  --disable-libiscsi \
  --disable-libnfs \
  --disable-mpath \
  --disable-nettle \
  --disable-opengl \
  --disable-pie \
  --disable-sdl \
  --disable-spice \
  --disable-tools \
  --disable-vte \
  --disable-werror \
  --disable-debug-info \
  --disable-glusterfs \
  --cross-prefix=$(xx-info)- \
  --host-cc=$(xx-clang --print-target-triple)-clang \
  --host=$(xx-clang --print-target-triple) \
  --build=$(TARGETPLATFORM= TARGETPAIR= xx-clang --print-target-triple) \
  --cc=$(xx-clang --print-target-triple)-clang \
  --extra-ldflags=-latomic \
  --target-list="$QEMU_TARGETS"
