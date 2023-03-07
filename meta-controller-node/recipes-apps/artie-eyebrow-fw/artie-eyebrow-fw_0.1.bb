SUMMARY = "Recipe to build and install Artie's eyebrow's firmware into the Yocto image."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=1E9371F56A983712955E7A22FE2F6F95"

# FW is part of the main Artie repository.
SRC_URI = "git://github.com/MaxStrange/Artie.git;protocol=https;branch=main;sha256sum=6e00c41bc0d2f9d7c61b83c3267b022acce497924e6a022e9241b52d85f0e6ac \
           git://github.com/raspberrypi/pico-examples.git;protocol=https;branch=main \
           git://github.com/raspberrypi/pico-extras.git;protocol=https;branch=main \
           git://github.com/raspberrypi/pico-playground.git;protocol=https;branch=main \
           git://github.com/vmilea/pico_i2c_slave;protocol=https;branch=main \
           gitsm://github.com/raspberrypi/pico-sdk.git;protocol=https;branch=main \
          "
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"

# Where to keep downloaded source files
S = "${WORKDIR}/git"

inherit cmake

ARTIE_FW_BUILD_TYPE = "Debug"
ARTIE_FW_LOG_LEVEL = "INFO"
EXTRA_OECMAKE = " -DCMAKE_BUILD_TYPE=${ARTIE_FW_BUILD_TYPE} -DLOG_LEVEL=${ARTIE_FW_LOG_LEVEL}"

# We cross compile using gcc-arm-none-eabi, etc.
DEPENDS += " cmake \
             gcc-arm-none-eabi \
             libnewlib-arm-none-eabi \
             build-essential \
             libstdc++-arm-none-eabi-newlib \
           "

# The i2c_slave library needs to be in a certain spot
# And the pico_sdk_import.cmake, likewise.
# Also set up ENV variable we need.
do_configure:append() {
    mv "${S}"/pico_i2c_slave/i2c_slave "${S}"/src/
    cp "${S}"/pico-sdk/external/pico_sdk_import.cmake "${S}"/src/pico_sdk_import.cmake
    export PICO_SDK_PATH="${S}/pico-sdk"
}
