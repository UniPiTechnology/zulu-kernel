#!/bin/bash
# echo the commands
# https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
set -o xtrace

apt-get -y install bc libssl-dev

. /ci-scripts/include.sh

# modify repo-patch-table
cat >/ci-scripts/repo_patch_table.txt <<EOF
bullseye-zulu-main    bullseye-zulu-main  bullseye-patron-main  bullseye-iris-main
bullseye-zulu-test    bullseye-zulu-test  bullseye-patron-test  bullseye-iris-test
bookworm-zulu-main    bookworm-zulu-main  bookworm-patron-main  bookworm-iris-main
bookworm-zulu-test    bookworm-zulu-test  bookworm-patron-test  bookworm-iris-test
EOF

./prepare.sh build
