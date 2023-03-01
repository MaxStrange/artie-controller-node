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

if [[ ! -d meta-splash ]]; then
    git clone https://github.com/hamzamac/meta-splash.git
    cp assets/splash.png meta-splash/recipes-core/psplash/files/logo.png
fi

if [[ ! -d meta-openembedded ]]; then
    git clone git://git.openembedded.org/meta-openembedded
    cd meta-openembedded
    git checkout -t origin/kirkstone -b kirkstone-local
    cd ..
fi

if [[ ! -d meta-virtualization ]]; then
    git clone https://git.yoctoproject.org/git/meta-virtualization
    cd meta-virtualization
    git checkout -t origin/kirkstone -b kirkstone-local
    cd ..
fi
