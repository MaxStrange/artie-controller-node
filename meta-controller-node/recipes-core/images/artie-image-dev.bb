SUMMARY = "A console-only image suitable for dev/debug work on Artie. NOT suitable for release."
LICENSE = "MIT"

inherit artie-image-base

IMAGE_INSTALL += " vim \
                   docker-check \
                 "
