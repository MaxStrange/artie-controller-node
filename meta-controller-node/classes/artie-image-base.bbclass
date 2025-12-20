SUMMARY = "The base image all the artie-controller-node images are based on."
LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += "splash"

IMAGE_INSTALL += " packagegroup-artie-cli \
                   packagegroup-network \
                   packagegroup-k3s-node \
                   docker \
                   expand-rootfs \
                   led-daemon \
                 "
