# Artie Controller Node

The Artie Project is an open source developmental robotics platform, research effort, and reference robot.
The documentation, the getting started guide, and the architecture overview live in the main
repository: https://github.com/ArtieBots/Artie

## Development

To initialize this repository (which should only be done for developing it - not building Artie),
simply run the `./setup.sh` script. This will pull all the layers that we need.

To build the image for development (not release), run `source poky/oe-init-build-env "$PWD"/build` from here
after running the setup script. Then run `bitbake <IMAGE>`, where <IMAGE> is one of:

* core-image-base
* artie-image-dev
