SUMMARY = "Recipe for adding Artie CLI application."
DESCRIPTION = "Recipe for adding Artie CLI application."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# CLI is part of the main Artie repository.
SRC_URI = "git://github.com/MaxStrange/Artie.git;protocol=https;branch=main"
SRC_URI[sha256sum] = "6e00c41bc0d2f9d7c61b83c3267b022acce497924e6a022e9241b52d85f0e6ac"
SRCREV = "${AUTOREV}"
PV = "1.0+git${SRCPV}"

# Where to keep downloaded source files
S = "${WORKDIR}/git"

# This will cause this recipe to act using the setuptools3 do_compile/do_install tasks
SETUPTOOLS_SETUP_PATH = "${S}/cli"
inherit setuptools3

RDEPENDS:${PN} += " python3 \
                    python3-modules \
                    python3-numpy \
                    python3-smbus2 \
                    rpi-gpio \
                    i2c-tools \
                  "

# Setuptools3 (at least in Kirkstone) assumes a setup.py.
# But new Python projects are discouraged from using a setup.py.
# So this step adds a setup.py script that simply calls setup()
# making use of the toml config in the repo instead.
do_configure:append() {
  touch "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "from setuptools import setup" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "setup(" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    name='artiecli'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    version='0.0.1'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    packages=['artiecli', 'artiecli.modules', 'artiecli.modules.hardware']," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    license='MIT'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    python_requires='>=3.6'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    install_requires=[" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "        'numpy'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "        'smbus2'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "        'RPi.GPIO'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    ]," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    entry_points={" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "        'console_scripts': [" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "            'artie-cli = artiecli.cli:main'," >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "        ]" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "    }" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo ")" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
  echo "" >> "${SETUPTOOLS_SETUP_PATH}"/setup.py
}
