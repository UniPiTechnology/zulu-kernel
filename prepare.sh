#!/bin/bash

set -e

NXP_TAG=lf-6.1.1-1.0.1

create_git_repo()
{
    git init
    git add .
    git commit -m "Init from ${NXP_TAG}"
    git am $1/*
}

patch_source()
{
    for p in $1/*; do
        patch -p1 <$p
    done
}


wget "https://github.com/nxp-imx/linux-imx/archive/refs/tags/${NXP_TAG}.tar.gz" -O- | tar xz

mv linux-imx-${NXP_TAG} linux-imx
(
  cd linux-imx
  if [ "$1" = "build" ]; then
      patch_source ../patches
  else 
      create_git_repo ../patches
  fi
)
