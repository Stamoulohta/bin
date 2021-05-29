#!/usr/bin/env bash

CURRENT="$HOME/lab/current"
PROJECT_PATH=$(realpath "$1")
HTTP_LOG="http-log"

rm -f "$CURRENT"
ln -s "$PROJECT_PATH" "$CURRENT"

mkdir -p "$CURRENT/$HTTP_LOG"

for CMD in st{op,art,"atus --no-pager"}
do
    srvr "$CMD"
done
