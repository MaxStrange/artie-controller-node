SUMMARY = "The base image all the artie-controller-node images are based on."

IMAGE_FEATURES += "splash"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL += " packagegroup-artie-cli \
                   pico-openocd \
                 "
