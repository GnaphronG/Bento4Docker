#! /bin/bash

set -e

if [ $# -lt 1 -o "$1" = "ls" ]; then
    cat << EOF
Bento4 in Docker $BENTO4_VERSION
Usage: bento4 tool [args ...]
       bento4 ls

Bento4 in Docker is a containerized version of Bento4,  
with support of http(s) url.

Available tools: 
`ls /opt/bento4/bin | sed -e '/.so$/d' -e 's/^/  /'`

See https://www.bento4.com/documentation/ for details on the command.
Running the tool without any argument will print out a summary of the tool’s command line options and parameters.
EOF
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
