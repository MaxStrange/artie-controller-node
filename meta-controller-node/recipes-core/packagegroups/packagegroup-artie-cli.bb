DESCRIPTION = "Artie CLI and dependencies."

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} += " python3 \
                    python3-modules \
                    python3-numpy \
                    python3-smbus2 \
                    rpi-gpio \
                    i2c-tools \
                    artie-cli \
                  "
