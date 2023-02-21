SUMMARY = "Recipe for adding Artie CLI application."
DESCRIPTION = "Recipe for adding Artie CLI application."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# CLI is part of the main Artie repository.
SRC_URI = "git://github.com/MaxStrange/Artie"

# Where to keep downloaded source files
S = "${WORKDIR}/src"

inherit setuptools3

RDEPENDS_${PN} += " python3 \
                    python3-modules \
                    python3-pyserial \
                  "

# Add the CLI directory into the rootfs
do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/Artie/cli/cli.py ${D}${bindir}
}
