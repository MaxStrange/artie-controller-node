FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://host-fragment"

do_install:append() {
    cat ${WORKDIR}/host-fragment >> ${D}${sysconfdir}/hosts
}
