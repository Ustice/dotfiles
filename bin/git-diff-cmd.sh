#!/bin/sh

# Fix for difftool on OS X.
# https://gist.github.com/bkeating/329690
/usr/bin/opendiff "$2" "$5" -merge "$1"
