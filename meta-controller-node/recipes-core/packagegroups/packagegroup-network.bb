DESCRIPTION = "NetworkManager and nmtui packages along with dependencies."

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} += " networkmanager \
                    networkmanager-nmtui \
                  "
