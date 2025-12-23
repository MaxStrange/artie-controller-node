#! /bin/bash
#
# Args:
# --insecure-registries <comma-separated list of insecure registries>
# --hosts <comma-separated list of 'host<space>address' entries to add to /etc/hosts>

POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -i|--insecure-registries)
      INSECURE_REGISTRIES="$2"
      shift # past argument
      shift # past value
      ;;
    -h|--hosts)
      HOSTS="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      shift # past argument
      ;;
  esac
done

# Clone Yocto
if [[ ! -d poky ]]; then
    git clone git://git.yoctoproject.org/poky
    cd poky
    git checkout -t origin/scarthgap -b scarthgap-local
    cd ..
fi

# Set up the build directory
source poky/oe-init-build-env "$PWD"/build
cp "$PWD"/conf/bblayers.ours.conf "$PWD"/conf/bblayers.conf
cp "$PWD"/conf/local.ours.conf "$PWD"/conf/local.conf
cd ..

# Download layers
if [[ ! -d meta-raspberrypi ]]; then
    git clone https://github.com/agherzan/meta-raspberrypi
    cd meta-raspberrypi
    git checkout -t origin/scarthgap -b scarthgap-local
    cd ..
fi

if [[ ! -d meta-splash ]]; then
    git clone https://github.com/hamzamac/meta-splash.git
fi

if [[ ! -d meta-openembedded ]]; then
    git clone git://git.openembedded.org/meta-openembedded
    cd meta-openembedded
    git checkout -t origin/scarthgap -b scarthgap-local
    cd ..
fi

if [[ ! -d meta-virtualization ]]; then
    git clone https://git.yoctoproject.org/git/meta-virtualization
    cd meta-virtualization
    git checkout -t origin/scarthgap -b scarthgap-local
    cd ..
fi

# Add splash file
cp assets/splash.png meta-splash/recipes-core/psplash/files/logo.png

DAEMON_PATH="meta-controller-node/recipes-apps/docker/files/daemon-fragment.json"
if [[ ! -f $DAEMON_PATH ]]; then
    touch $DAEMON_PATH
    echo "{" >> $DAEMON_PATH
    echo "  \"insecure-registries\": [" >> $DAEMON_PATH
    echo "    $(echo $INSECURE_REGISTRIES | tr ',' '\n' | sed 's/^/"/' | sed 's/$/"/' | paste -sd, -)" >> $DAEMON_PATH
    echo "  ]" >> $DAEMON_PATH
    echo "}" >> $DAEMON_PATH
fi

HOST_PATH="meta-controller-node/recipes-core/network/files/host-fragment"
if [[ ! -f $HOST_PATH ]]; then
    touch $HOST_PATH
    echo "# Custom /etc/hosts entries" >> $HOST_PATH
    echo "" >> $HOST_PATH
    echo "$HOSTS" | tr ',' '\n' >> $HOST_PATH
    echo "" >> $HOST_PATH
fi
