SUMMARY = "Recipe for adding the Docker Compose script to the image. This is used for development."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI = "file://compose.yaml"
PV = "0.1"

S = "${WORKDIR}"

RDEPENDS:${PN} += " python3-docker-compose \
                  "
FILES:${PN} = "${ARTIE_FOLDER} \
               ${ARTIE_FOLDER}/compose.yaml \
              "

# Do nothing for the default tasks
do_compile() {
}
do_build() {
}
do_configure() {
}

# Install the compose file to the root directory
do_install() {
    install -d ${D}${ARTIE_FOLDER}
    install -m 0755 ${S}/compose.yaml ${D}${ARTIE_FOLDER}/compose.yaml
}
