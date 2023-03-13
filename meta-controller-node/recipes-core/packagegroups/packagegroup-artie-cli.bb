DESCRIPTION = "Artie CLI and dependencies."

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} += " python3 \
                    python3-modules \
                    python3-smbus2 \
                    artie-cli \
                    artie-i2c \
                    artie-util \
                  "
