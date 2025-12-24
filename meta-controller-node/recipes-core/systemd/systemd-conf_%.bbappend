FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://systemd-networkd-wait-online-override.conf \
    file://80-wifi-station.network \
"

FILES:${PN} += " \
    ${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/override.conf \
    ${sysconfdir}/systemd/network/80-wifi-station.network \
"

# Patch the systemd-networkd-wait-online service so that it doesn't timeout after several minutes
# of waiting for *all* the interfaces to configure (we only need one).
#
# Also create the wifi-station.network file to ensure that the wifi interface is brought up
# during boot.
do_install:append() {
    install -d ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d
    install -m 0644 ${WORKDIR}/systemd-networkd-wait-online-override.conf ${D}${sysconfdir}/systemd/system/systemd-networkd-wait-online.service.d/override.conf

    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/80-wifi-station.network ${D}${sysconfdir}/systemd/network/80-wifi-station.network
}
