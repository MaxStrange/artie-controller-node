# I have taken this from the following link under Apache 2.0 license:
# https://github.com/jackiehjm/meta-akraino/blob/master/recipes-extended/cloud-utils-growpart/cloud-utils-growpart_0.29.bb
#
# The copyright and whatnot follows.
#
# Copyright (C) 2019 Wind River Systems, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

SUMMARY = "Script for growing a partition"
HOMEPAGE = "https://launchpad.net/cloud-utils"
LICENSE = "GPL-3.0-only"

LIC_FILES_CHKSUM = "file://LICENSE;md5=d32239bcb673463ab874e80d47fae504"

SRC_URI = "https://launchpad.net/cloud-utils/trunk/${PV}/+download/cloud-utils-${PV}.tar.gz"

SRC_URI[md5sum] = "73be1c4ac3f00044459269ed1778e7f3"
SRC_URI[sha256sum] = "9ea1b66f5a4798c8d6eeca48d908e11169a38e943efa433b7ec5dffa907e257c"

S = "${WORKDIR}/cloud-utils-${PV}"

# This package owns the growpart script
FILES:${PN} = "${bindir}/growpart"

# We depend on a couple of things
RDEPENDS_${PN} = " \
    gawk \
    util-linux \
"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/bin/growpart ${D}${bindir}
}
