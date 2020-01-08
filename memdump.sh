#!/usr/bin/env bash

if [ $EUID != 0 ]; then
    echo "You must be root." 1>&2
    exit 2
fi

FROM=$((${1:-0}))
SIZE=$((${2:-16}))
FILE=${3:-/dev/mem}

#hexdump --canonical --skip "$FROM" --length "$SIZE" "$FILE"

dd bs=1 skip="$FROM" count="$SIZE" if=$FILE | hexdump -C
