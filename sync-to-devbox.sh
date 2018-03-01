#!/usr/bin/env bash

set -e

if [ -z "$DEVBOX" ]; then
    echo "set \$DEVBOX" >&2
    exit 1
fi

DEVBOX_USER="${DEVBOX_USER:-ubuntu}"

DEVBOX_TARGET="${DEVBOX_TARGET:-/home/ubuntu/go/src/k8s.io/kubernetes/}"

cd "$(dirname $0)"
rsync -aLvzh --exclude='my_buildlog.txt' --exclude='_output' --exclude='.make' --exclude='.idea' --delete -e ssh . "${DEVBOX_USER}@${DEVBOX}:${DEVBOX_TARGET}"
