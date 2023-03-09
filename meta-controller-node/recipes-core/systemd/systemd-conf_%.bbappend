FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://systemd-networkd-wait-online-override.conf \
"

FILES:${PN} += " \
    ${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/override.conf \
"

# Patch the systemd-networkd-wait-online service so that it doesn't timeout after several minutes
# of waiting for *all* the interfaces to configure (we only need one).
do_install:append() {
    install -d ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d
    install -m 0644 ${WORKDIR}/systemd-networkd-wait-online-override.conf ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/override.conf
}
