#!/bin/bash
# echo the commands
# https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
set -o xtrace
apt-get -y install bc libssl-dev

. /ci-scripts/include.sh

# the debian/control needs to be altered for older distros
if [ "$DEBIAN_VERSION" == "buster" ] || [ "$DEBIAN_VERSION" == "stretch" ]; then
    sed -i 's/###KERNEL_PACKAGE_NAME###/zulu-kernel-image/g' debian/control
    sed -i 's/###HEADERS_PACKAGE_NAME###/zulu-kernel-headers/g' debian/control
    sed -i 's/###DEPENDS###/zulu-u-boot (>=0.34)/g' debian/control
else
    sed -i 's/###KERNEL_PACKAGE_NAME###/unipi-kernel-image/g' debian/control
    sed -i 's/###HEADERS_PACKAGE_NAME###/unipi-kernel-headers/g' debian/control
    sed -i 's/###DEPENDS###/unipi-u-boot (>=0.34)/g' debian/control
fi

# modify repo-patch-table
cat >/ci-scripts/repo_patch_table.txt <<EOF
bullseye-zulu-main    bullseye-zulu-main  bullseye-patron-main  bullseye-iris-main
bullseye-zulu-test    bullseye-zulu-test  bullseye-patron-test  bullseye-iris-test buster-zulu-test
EOF
