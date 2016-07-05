#!/bin/bash
#
# Builds Docker image.
#
set -euo pipefail

BUILD_DIR="$(mktemp -d)"
cp Dockerfile "$BUILD_DIR/"
cp run.sh "$BUILD_DIR/"
ARCH="$(uname -m)"
IMAGE="hkjn/openvpn"
[[ $ARCH = "x86_64" ]] || {
  # TODO(hkjn): Improve this special-casing to support different CPU
  # architectures. Just call it hkjn/x86_64-alpine as well?
  sed -i "s/FROM hkjn\//FROM hkjn\/$ARCH-/" "$BUILD_DIR/Dockerfile"
  IMAGE="hkjn/$ARCH-openvpn"
}

docker build -t $IMAGE "$BUILD_DIR/"
NO_PUSH=${NO_PUSH:-""}
[[ "$NO_PUSH" ]] || docker push $IMAGE

