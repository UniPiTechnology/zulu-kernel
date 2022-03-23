#!/bin/bash
# echo the commands
# https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
set -o xtrace
apt-get -y install bc libssl-dev

. /ci-scripts/include.sh

# the debian/control needs to be altered for different distros
if [ "$DEBIAN_VERSION" == "buster" ] || [ "$DEBIAN_VERSION" == "stretch" ]; then
    sed -i 's/###KERNEL_PACKAGE_NAME###/zulu-kernel-image/g' debian/control
    sed -i 's/###KERNEL_DEPENDS###/zulu-u-boot (>=0.34)/g' debian/control
    # deletes the Replaces and Breaks line because it doesn't replace anything
    sed -i '/###KERNEL_REPLACES###/d' debian/control
    sed -i '/###KERNEL_BREAKS###/d' debian/control

    sed -i 's/###HEADERS_PACKAGE_NAME###/zulu-kernel-headers/g' debian/control
    # deletes the Replaces and Breaks line because it doesn't replace anything
    sed -i '/###HEADERS_REPLACES###/d' debian/control
    sed -i '/###HEADERS_BREAKS###/d' debian/control

    sed -i 's/###HEADERS_PACKAGE_NAME###/zulu-kernel-headers/g' debian/rules
else
    sed -i 's/###KERNEL_PACKAGE_NAME###/unipi-kernel/g' debian/control
    sed -i 's/###KERNEL_DEPENDS###/unipi-u-boot (>=0.34)/g' debian/control
    sed -i 's/###KERNEL_REPLACES###/zulu-kernel-image/g' debian/control
    sed -i 's/###KERNEL_BREAKS###/zulu-kernel-image/g' debian/control

    sed -i 's/###HEADERS_PACKAGE_NAME###/unipi-kernel-headers/g' debian/control
    sed -i 's/###HEADERS_REPLACES###/zulu-kernel-headers/g' debian/control
    sed -i 's/###HEADERS_BREAKS###/zulu-kernel-headers/g' debian/control

    sed -i 's/###HEADERS_PACKAGE_NAME###/unipi-kernel-headers/g' debian/rules
fi

# modify repo-patch-table
cat >/ci-scripts/repo_patch_table.txt <<EOF
bullseye-zulu-main    bullseye-zulu-main  bullseye-patron-main  bullseye-iris-main
bullseye-zulu-test    bullseye-zulu-test  bullseye-patron-test  bullseye-iris-test buster-zulu-test
EOF
