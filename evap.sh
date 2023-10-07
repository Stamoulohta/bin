#!/usr/bin/env bash
# vim: set fileencoding=utf-8 ts=4 sw=4 expandtab :
#======================================================================================================================#
#
# Send document to cloud (paperless.ngx)
#
#======================================================================================================================#

rhost="free"
rpath="paperless"

if ! $(hash rsync 2>/dev/null)
then
    echo "Error: rsync not found." >&2
    exit 1
fi

echo "Vaporizing: $@"

rsync --copy-links --update --times --progress "$@" "$rhost":"$rpath"

exit;
