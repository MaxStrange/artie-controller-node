SUMMARY = "Recipe for adding the Docker compatability checker script to the image."
DESCRIPTION = "${SUMMARY}\nTo use the check-config.sh script, you first need to run `modprobe configs` to enable the /proc/config.gz file."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# CLI is part of the main Artie repository.
SRC_URI = "git://github.com/moby/moby.git;protocol=https;nobranch=1;rev=bc3805a0a0d3b5bd3f0e6c69f46ac08dd53377c7"
PV = "23.0.1+git${SRCPV}"

# Where to keep downloaded source files
S = "${WORKDIR}/git"

# The script requires bash to operate properly
RDEPENDS:${PN} += " bash \
                  "

FILES:${PN} = "check-config.sh"

# Do nothing for the default tasks
do_compile() {
}
do_build() {
}
do_configure() {
}

# Install the script to the root directory
do_install() {
    install -m 0755 ${S}/contrib/check-config.sh ${D}/check-config.sh
}
