#!/bin/bash
# echo the commands
# https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
set -o xtrace

. /ci-scripts/include.sh

apt-get -y install bc libssl-dev

# the debian/control has to be altered based on the Debian version
if [ "$DEBIAN_VERSION" == "buster" ] || [ "$DEBIAN_VERSION" == "stretch" ]; then
    sed -i 's/###DEPENDS###/zulu-u-boot (>=0.34)/' debian/control
else
    sed -i 's/###DEPENDS###/unipi-u-boot/' debian/control
fi

# modify repo-patch-table
cat >/ci-scripts/repo_patch_table.txt <<EOF
bullseye-zulu-main    bullseye-zulu-main  bullseye-patron-main  bullseye-iris-main
bullseye-zulu-test    bullseye-zulu-test  bullseye-patron-test  bullseye-iris-test buster-zulu-test
EOF
