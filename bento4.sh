#! /bin/bash

set -e

if [ "$1" = "ls" ]; then
    ls /opt/bento4/bin | grep -v '.so'
else
    args="$1"
    tmpd=`mktemp -d`
    cd /mnt
    for arg in ${@:2}; do
        if echo $arg | grep -q '^http'; then
            tmp=`mktemp -p $tmpd`
            curl -s -o $tmp $arg
            arg=$tmp
        fi
        args="${args} ${arg}"
    done
    /opt/bento4/bin/$args
    rm -rf $tmpd
fi
