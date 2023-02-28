SUMMARY = "Recipe for adding Artie Raspberry Pi Pico-compliant OpenOCD application."
DESCRIPTION = "${SUMMARY}"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
SRC_URI = " \
    git://repo.or.cz/openocd.git;protocol=http;name=openocd;branch=rp2040 \
    git://repo.or.cz/r/git2cl.git;protocol=http;destsuffix=tools/git2cl;name=git2cl;branch=master \
    git://repo.or.cz/r/jimtcl.git;protocol=http;destsuffix=git/jimtcl;name=jimtcl;branch=master \
    git://repo.or.cz/r/libjaylink.git;protocol=http;destsuffix=git/src/jtag/drivers/libjaylink;name=libjaylink;branch=master \
"
SRCREV_FORMAT = "openocd"
SRCREV_openocd = "8e3c38f78730ce878ff81448bc3f6c1e6bb06e13"
SRCREV_git2cl = "8373c9f74993e218a08819cbcdbab3f3564bbeba"
SRCREV_jimtcl = "0aa0fb4e3a38d38a49de9eb585d93d63a370dcf6"
SRCREV_libjaylink = "9aa7a5957c07bb6e862fc1a6d3153d109c7407e4"

PV = "0.11+gitr${SRCPV}"
S = "${WORKDIR}/git"

inherit pkgconfig autotools-brokensep gettext

BBCLASSEXTEND += "native nativesdk"

EXTRA_OECONF = "--enable-ftdi --disable-doxygen-html --disable-werror --enable-sysfsgpio --enable-bcm2835gpio"
EXTRA_OECONF += " --enable-sysfsgpio --enable-bcm2835gpio"

do_configure() {
    ./bootstrap nosubmodule
    install -m 0755 ${STAGING_DATADIR_NATIVE}/gnu-config/config.guess ${S}/jimtcl/autosetup
    install -m 0755 ${STAGING_DATADIR_NATIVE}/gnu-config/config.sub ${S}/jimtcl/autosetup
    oe_runconf ${EXTRA_OECONF}
}

do_install() {
    oe_runmake DESTDIR=${D} install
    if [ -e "${D}${infodir}" ]; then
      rm -Rf ${D}${infodir}
    fi
    if [ -e "${D}${mandir}" ]; then
      rm -Rf ${D}${mandir}
    fi
    if [ -e "${D}${bindir}/.debug" ]; then
      rm -Rf ${D}${bindir}/.debug
    fi
}

FILES:${PN} = " \
  ${datadir}/openocd/* \
  ${bindir}/openocd \
  "

PACKAGECONFIG[sysfsgpio] = "--enable-sysfsgpio,--disable-sysfsgpio"
PACKAGECONFIG[remote-bitbang] = "--enable-remote-bitbang,--disable-remote-bitbang"
PACKAGECONFIG ??= "sysfsgpio remote-bitbang"

# Can't be built with ccache
CCACHE_DISABLE = "1"
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
