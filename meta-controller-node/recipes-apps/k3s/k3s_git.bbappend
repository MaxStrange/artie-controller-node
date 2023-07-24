SUMMARY = "Recipe for adding a K3S configuration file."
DESCRIPTION = "${SUMMARY}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://config.yaml \
           "

FILES:${PN} = "${sysconfdir}/rancher/k3s \
               ${sysconfdir}/rancher/k3s/config.yaml \
              "

do_install:append() {
    # Install our configuration file for K3S
    install -d ${D}${sysconfdir}/rancher/k3s
    install -m 0644 ${WORKDIR}/config.yaml ${D}${sysconfdir}/rancher/k3s/config.yaml
}
