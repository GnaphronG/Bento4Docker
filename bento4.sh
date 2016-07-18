#! /bin/bash

set -e
EXEC_PREFIX=/opt/bento4/bin
MOUNTPOINT=/mnt

if [ $# -lt 1 -o "$1" = "ls" ]; then
    cat << EOF
Bento4 in Docker $BENTO4_VERSION
Usage: bento4 tool [args ...]
       bento4 ls

Bento4 in Docker is a containerized version of Bento4,  
with support of HTTP(S) URL.

if URL ends with @[0-9]+-[0-9]*, the part of the URL string from the '@' 
(without quotes) until the end of the string will be removed and the 
ending paramter with be converted into a HTTP range header
(https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35).

Available tools: 
`ls $WORKDIR/bin/* $WORKDIR/utils/* | sed -e '/.so$/d' -e 's/.*\/\([^/]\+\)$/  \1/'`

See https://www.bento4.com/documentation/ for details on the command.
Running the tool without any argument will print out a summary of the tool’s command line options and parameters.
EOF
else
    args="$1"
    tmpd=`mktemp -d`
    cd $MOUNTPOINT
    for arg in ${@:2}; do
        if echo $arg | grep -q '^http'; then
            tmp=`mktemp -p $tmpd`
            echo $arg | sed -e 's/^\(.*\)@\([0-9]\+-[0-9]*\)$/-H "Range:bytes=\2" \1/' | xargs curl -s -o $tmp
            arg=$tmp
        fi
        args="${args} ${arg}"
    done
    $EXEC_PREFIX/$args

    rm -rf $tmpd
fi
