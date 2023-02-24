# Generated by `pipoe --package smbus2`
SUMMARY = "smbus2 is a drop-in replacement for smbus-cffi/smbus-python in pure Python"
HOMEPAGE = "https://github.com/kplindegaard/smbus2"
AUTHOR = "Karl-Petter Lindegaard <kp.lindegaard@gmail.com>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=2a3eca2de44816126b3c6f33811a9fba"

SRC_URI = "https://files.pythonhosted.org/packages/7c/01/18a9c3fccc2ddc0af16ddbe52aadc4585fbd1e7ae4ee32e780abbfc7fc97/smbus2-0.4.2.tar.gz"
SRC_URI[md5sum] = "c561cbc6fb87fab7953b79e5aa148b81"
SRC_URI[sha256sum] = "634541ed794068a822fe7499f1577468b9d4641b68dd9bfb6d0eb7270f4d2a32"

S = "${WORKDIR}/smbus2-0.4.2"

RDEPENDS_${PN} = ""

inherit setuptools3
