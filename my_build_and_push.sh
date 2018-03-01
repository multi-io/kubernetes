#!/usr/bin/env bash

set -ex

export REGISTRY=oklischat
export VERSION="$(git rev-parse HEAD | head -c 12)"

## these two taken from "make quick-release"
export KUBE_RELEASE_RUN_TESTS=n
export KUBE_FASTBUILD=true

build/run.sh make cross

make -C cluster/images/hyperkube build

docker push "${REGISTRY}/hyperkube-amd64:${VERSION}"
