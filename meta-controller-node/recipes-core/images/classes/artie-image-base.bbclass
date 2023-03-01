SUMMARY = "The base image all the artie-controller-node images are based on."
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "splash"

IMAGE_INSTALL += " packagegroup-artie-cli \
                   openocd \
                 "
