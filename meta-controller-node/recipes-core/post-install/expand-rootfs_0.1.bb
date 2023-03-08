SUMMARY = "Recipe for adding a script that will run the resize program on first boot."
DESCRIPTION = "${SUMMARY}"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS:${PN} += " bash \
                    e2fsprogs-resize2fs \
                    cloud-utils-growpart \
                  "

# If we don't add this line, the build won't include this recipe into the rootfs,
# even though the pkg_postinst_ontarget function should include a systemd script implicitly.
# It will also fail with a strange error about "no match found".
ALLOW_EMPTY:${PN} = "1"

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

# Resize the filesystem on first boot
pkg_postinst_ontarget:${PN}() {
    #! /bin/bash
    growpart /dev/mmcblk0 2
    resize2fs /dev/mmcblk0p2
}
