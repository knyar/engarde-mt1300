#!/usr/bin/env bash
# Build Engarde client inside an OpenWrt SDK.

set -xeuo pipefail

SDK_PATH=${1:-}
PKG_DIR=$(dirname "$0")/openwrt

rsync -a --delete "$PKG_DIR/" "$SDK_PATH/package/engarde-client/"

pushd "$SDK_PATH" >/dev/null
./scripts/feeds update -a
./scripts/feeds install -a
make defconfig
make package/engarde-client/compile -j"$(nproc)" V=s
popd >/dev/null

echo "IPK files are under $SDK_PATH/bin/packages/*/base/"
