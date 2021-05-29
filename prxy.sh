#! /usr/bin/env bash

# Path Proxy
#
# Create a symlink to this with the name of the executable
# you'd like to run inside containing directories.

"$PWD/${0##*/}" $@
