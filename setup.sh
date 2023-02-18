#! /bin/bash

# Clone Yocto
if [[ ! -d poky ]]; then
    git clone git://git.yoctoproject.org/poky
    cd poky
    git checkout -t origin/kirkstone -b kirkstone-local
    cd ..
fi

# Set up the build directory
source poky/oe-init-build-env "$PWD"/build
cp "$PWD"/conf/bblayers.ours.conf "$PWD"/conf/bblayers.conf
cp "$PWD"/conf/local.ours.conf "$PWD"/conf/local.conf
cd ..

# Download layers
if [[ ! -d meta-raspberrypi ]]; then
    git clone https://github.com/agherzan/meta-raspberrypi
    cd meta-raspberrypi
    git checkout -t origin/kirkstone -b kirkstone-local
    cd ..
fi
