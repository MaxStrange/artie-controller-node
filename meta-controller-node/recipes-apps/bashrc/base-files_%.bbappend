SUMMARY = "Set up a .bashrc file for root user."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS:${PN} += " bash \
                  "

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://dot.profile \
           "

do_install:append() {
    echo "\n\
# Color ls command\n\
export LS_OPTIONS='--color=auto'\n\
eval `dircolors`\n\
alias ls='ls $LS_OPTIONS'\n\
\n\
# Keep dmesg from spouting stuff at us all the time\n\
dmesg -n 1\n" >> ${D}${sysconfdir}/profile
}
