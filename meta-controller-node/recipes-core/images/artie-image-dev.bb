SUMMARY = "A console-only image suitable for dev/debug work on Artie. NOT suitable for release."

IMAGE_FEATURES += "splash"

LICENSE = "MIT"

inherit core-image

# Include application(s) and dependencies
IMAGE_INSTALL += " python3 \
                   python3-modules \
                   python3-numpy \
                   python3-smbus2 \
                   rpi-gpio \
                 "
IMAGE_INSTALL += " artie-cli \
                 "
