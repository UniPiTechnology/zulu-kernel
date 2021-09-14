#!/bin/bash
# echo the commands
# https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
set -o xtrace
apt-get -y install bc libssl-dev

# modify repo-patch-table

cat >/ci-scripts/repo_patch_table.txt <<EOF
buster-zulu-main      buster-zulu-main bullseye-zulu-main  bullseye-patron-main  bullseye-iris-main
buster-zulu-test      buster-zulu-test bullseye-zulu-test  bullseye-patron-test  bullseye-iris-test
EOF
