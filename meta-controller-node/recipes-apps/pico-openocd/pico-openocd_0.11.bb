SUMMARY = "Recipe for adding Artie Raspberry Pi Pico-compliant OpenOCD application."
DESCRIPTION = "${SUMMARY}"

S = "${WORKDIR}/git"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"
SRC_URI = "gitsm://github.com/raspberrypi/openocd.git;protocol=https;branch=rp2040"

inherit autotools

# We depend on a few packages to build
DEPENDS += " texinfo libftdi libusb1"

## Need to run a bootstrap script before the usual autotools stuff
## autotools class has an EXTRACONFFUNCS variable for hooking additional preconfiguration functions,
## so we use that (rather than do_configure:prepend).
#openocd_bootstrap() {
#    sed -i '2icd ${S}' "${S}"/bootstrap
#    "${S}"/bootstrap
#}
#EXTRACONFFUNCS += " openocd_bootstrap"
#
## We don't want autotools' usual way of configuring, since the bootstrap script does it for us.
#autotools_do_configure() {
#    oe_runconf
#}
#do_configure[prefuncs] += "autotools_preconfigure autotools_aclocals ${EXTRACONFFUNCS}"
#do_configure[postfuncs] += "autotools_postconfigure"
#do_configure[file-checksums] += "${@' '.join(siteinfo_get_files(d, sysrootcache=False)[1])}"

EXTRA_OECONF += " --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio"

#cd ~/pico
#sudo apt install automake autoconf build-essential texinfo libtool libftdi-dev libusb-1.0-0-dev
#git clone https://github.com/raspberrypi/openocd.git --branch rp2040 --recursive --depth=1
#cd openocd
#./bootstrap
#./configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio
#make -j4
#sudo make install
