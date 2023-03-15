SUMMARY = "Recipe for adding Artie controller node's LED daemon."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# CLI is part of the main Artie repository.
SRC_URI = "git://github.com/MaxStrange/Artie.git;protocol=https;branch=main \
           file://led-daemon.service \
          "
SRC_URI[sha256sum] = "${ARTIE_RELEASE_SHA256}"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"

# Where to keep downloaded source files
S = "${WORKDIR}/git"

RDEPENDS:${PN} += " python3 \
                    python3-core \
                    python3-modules \
                    artie-i2c \
                    artie-util \
                    rpi-gpio \
                  "

LED_DAEMON_INSTALL_PATH = "${sysconfdir}/systemd/system/led-daemon.service"
FILES:${PN} = "${LED_DAEMON_INSTALL_PATH} \
               ${bindir}/leddaemon.py \
              "

# Do nothing for the default tasks
do_compile() {
    :
}
do_build() {
    :
}
do_configure() {
    :
}

# Install into systemd
do_install() {
    install -d ${D}${sysconfdir}/systemd/system
    install -d ${D}${bindir}
    install -m 0644 ${WORKDIR}/led-daemon.service ${D}${LED_DAEMON_INSTALL_PATH}
    install -m 0744 ${S}/drivers/controller-node-led/leddaemon.py ${D}${bindir}/leddaemon.py
}
