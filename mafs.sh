#!/usr/bin/env bash
# vim: set fileencoding=utf-8 ts=4 sw=4 expandtab :
#======================================================================================================================#
#
# Detects Amiga Partition Tables Positions and mounts Amiga Fast File Systems
#
# acknowledgements:
# https://gareth.halfacree.co.uk/2013/03/mounting-amiga-ffs-hard-drives-under-linux
#
#======================================================================================================================#

# print usage
usage() {
    cat <<USAGE_DOC
    $0 block_device part_number mount_point
USAGE_DOC
}

# assert argc = 3
if  [ $# -ne 3 ]; then
   usage
   exit 1
fi

# assert running as root
if [ "$EUID" -ne 0 ]
  then echo "Error: you are not root"
  exit 2
fi

# assert arg1 exists and is a block device
if [ ! -e "$1" ]; then
    echo "Error: '$1' not found."
    exit 2
elif [ ! -b "$1" ]; then
    echo "Error: '$1' is not a block device."
    exit 2
fi

# assert arg2 is numeric
case "$2" in
    ''|*[!0-9]*) echo "Error: '$2' is not a valid partition number"
        exit 2;;
esac

# assert arg3 exists and is a directory
if [ ! -d "$3" ]; then
    echo "Error: '$1' is not a directory."
    exit 2
fi

PROG='$1 == part_number {offset=substr($2, 1, length($2)-1); sizelimit=substr($4, 1, length($4)-1); cmd=sprintf("mount -t affs -o offset=%d,sizelimit=%d %s %s", offset, sizelimit, block_device, mount_point); system(cmd)} END{if (!cmd) printf("partition %d not found\n", part_number) > "/dev/stderr"}'

awk -F: -v block_device="$1" -v part_number="$2" -v mount_point="$3" "$PROG" <(parted --machine "$1" unit b print quit)
