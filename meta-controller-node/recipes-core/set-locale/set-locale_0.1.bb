SUMMARY = "Set up the /etc/locale.conf file"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://locale.conf \
          "
SRC_URI[sha256sum] = "${ARTIE_RELEASE_SHA256}"
SRCREV = "${AUTOREV}"
PV = "0.1+git${SRCPV}"

# This package owns the locale.conf file
LOCALE_INSTALL_PATH = "${sysconfdir}/locale.conf"
FILES:${PN} = "${LOCALE_INSTALL_PATH}"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/locale.conf ${D}${LOCALE_INSTALL_PATH}
}
