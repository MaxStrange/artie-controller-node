DESCRIPTION = "Artie application-level packages that are useful for debugging/development."

inherit packagegroup

PACKAGES = "${PN}"

RDEPENDS:${PN} += " artie-eyebrow-fw \
                  "
