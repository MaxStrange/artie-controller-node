SUMMARY = "Recipe for adding Artie I2C Python library."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# CLI is part of the main Artie repository.
SRC_URI = "git://github.com/MaxStrange/Artie.git;protocol=https;branch=main"
SRC_URI[sha256sum] = "254fd7ed5b2fd36ee51f3249a7685dcb9372d4a1"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"

# Where to keep downloaded source files
S = "${WORKDIR}/git"

# This will cause this recipe to act using the setuptools3 do_compile/do_install tasks
SETUPTOOLS_SETUP_PATH = "${S}/libraries/artie-i2c"
inherit setuptools3

RDEPENDS:${PN} += " python3 \
                    python3-modules \
                    python3-smbus2 \
                    artie-util \
                    i2c-tools \
                  "

do_configure:prepend() {
  rm -f ${SETUPTOOLS_SETUP_PATH}/pyproject.toml
}
