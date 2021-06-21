#!/usr/bin/env bash

: ${SRVRUSR:=http}
ARG=${1:-.}

if id "$SRVRUSR" >/dev/null 2>&1;
then CURRENT=$(eval echo "~$SRVRUSR")
else CURRENT=/srvr/http
fi

PROJECT_PATH=$(realpath "$ARG")
HTTP_LOG="http-log"

rm --force "$CURRENT"
ln --symbolic "$PROJECT_PATH" "$CURRENT"

sudo install -d -m 0775 -g "$SRVRUSR" "$CURRENT/$HTTP_LOG"

for CMD in st{op,art,"atus --no-pager"}
do
    srvr "$CMD"
done
