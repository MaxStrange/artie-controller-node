SUMMARY = "A console-only image suitable for dev/debug work on Artie. NOT suitable for release."

IMAGE_FEATURES += "splash"

LICENSE = "MIT"

inherit core-image

# Include application(s) and dependencies
IMAGE_INSTALL += " artie-cli \
                 "
