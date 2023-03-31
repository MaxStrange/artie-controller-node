SUMMARY = "Add a normal (non-template) sshd service file to systemd."
DESCRIPTION = "${SUMMARY}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " file://sshd.service \
           "

do_install:append() {
	install -d ${D}${systemd_system_unitdir}
	install -c -m 0644 ${WORKDIR}/sshd.service ${D}${systemd_system_unitdir}

	sed -i -e 's,@BASE_BINDIR@,${base_bindir},g' \
		-e 's,@SBINDIR@,${sbindir},g' \
		-e 's,@BINDIR@,${bindir},g' \
		-e 's,@LIBEXECDIR@,${libexecdir}/${BPN},g' \
		${D}${systemd_system_unitdir}/sshd.service
}
