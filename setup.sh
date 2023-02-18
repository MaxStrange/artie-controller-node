#! /bin/bash

# Clone Yocto
git clone git://git.yoctoproject.org/poky
cd poky
git checkout -t origin/kirkstone -b kirkstone-dev
cd ..

# Set up the build directory
source poky/oe-init-build-env "$PWD"/build
