SUMMARY = "Recipe for adding Artie Raspberry Pi Pico-compliant OpenOCD application."
DESCRIPTION = "${SUMMARY}"

# Need to add another SWD OpenOCD config file
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# We use a different branch (base recipe uses master)
SRC_URI = " \
    git://github.com/raspberrypi/openocd.git;protocol=http;name=openocd;branch=rp2040 \
    git://repo.or.cz/r/git2cl.git;protocol=http;destsuffix=tools/git2cl;name=git2cl;branch=master \
    git://repo.or.cz/r/jimtcl.git;protocol=http;destsuffix=git/jimtcl;name=jimtcl;branch=master \
    git://repo.or.cz/r/libjaylink.git;protocol=http;destsuffix=git/src/jtag/drivers/libjaylink;name=libjaylink;branch=master \
"
SRCREV_FORMAT = "openocd"
SRCREV_openocd = "8e3c38f78730ce878ff81448bc3f6c1e6bb06e13"

# We want to enable rpi GPIO for openOCD debug/FW loading
EXTRA_OECONF += " --enable-bcm2835gpio"

# Add another raspberrypi OpenOCD config to OpenOCD's interfaces folder
do_install:append() {
    install -d ${D}/usr/share/openocd/scripts/interface
    install -m 0644 -d ${WORKDIR}/raspberrypi-right-swd.cfg ${D}/usr/share/openocd/scripts/interface/raspberrypi-right-swd.cfg
    install -m 0644 -d ${WORKDIR}/raspberrypi-mouth-swd.cfg ${D}/usr/share/openocd/scripts/interface/raspberrypi-mouth-swd.cfg
}
