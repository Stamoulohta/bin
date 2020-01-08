#! /usr/bin/env bash

if [ $EUID != 0 ]; then
    echo "You must be root." 1>&2
    exit 2
fi


for f in $(find / -iname "*.pacnew")
do
    vimdiff $f ${f%.*}
done
