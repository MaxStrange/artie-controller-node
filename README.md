# Artie Controller Node

This is Artie's controller node's Yocto build configuration. To build Artie,
please see [the Artie repository](https://github.com/MaxStrange/Artie/tree/master).

## Development

To initialize this repository (which should only be done for developing it - not building Artie),
simply run the `./setup.sh` script. This will pull all the layers that we need.

To build the image for development (not release), run `source poky/oe-init-build-env "$PWD"/build` from here
after running the setup script. Then run `bitbake <IMAGE>`, where <IMAGE> is TODO.
