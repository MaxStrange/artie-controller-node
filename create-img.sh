#! /bin/bash
IMAGESDIR=$(pwd)/build/tmp/deploy/images/raspberrypi4-64
RTFS_NAME="core-image-base-raspberrypi4-64.tar.bz2"

# All the stuff we need to copy to the SD card image
KERNELIMG=${IMAGESDIR}/Image
DTBS=${IMAGESDIR}/bcm2711-rpi-4-b.dtb
BOOTFILESDIR=${IMAGESDIR}/bootfiles
RTFS=${IMAGESDIR}/${RTFS_NAME}
PI_IMG=$(pwd)/pi.img
TARGET_HOSTNAME="artie-controller-node"

# Check for the right files before we do anything
if [ ! -f ${KERNELIMG} ]; then
    echo "No Image file found at ${KERNELIMG}"
    exit 1
fi

if [ ! -f ${DTBS} ]; then
    echo "No DTBS found at ${DTBS}"
    exit 1
fi

if [ ! -d ${BOOTFILESDIR} ]; then
    echo "No boofiles directory found at ${BOOTFILESDIR}"
    exit 1
fi

if [ ! -f ${RTFS} ]; then
    echo "No root filesystem found at ${RTFS}"
fi

# Create the pi.img file
dd if=/dev/zero of=${PI_IMG} bs=128M count=16

# Set up the file as a loopback device
LOOPDEV=$(sudo losetup -fP ${PI_IMG} --show)

# Tell fdisk to partition the file into two parts: FAT and ext4
sudo fdisk $LOOPDEV << EOF
o
n
p
1

+256m
t
c
n
p
2



w
q
EOF
sync

# Set up the actual filesystems
sudo mkfs.vfat -F 32 "${LOOPDEV}"p1
sudo mkfs.ext4 -F -q "${LOOPDEV}"p2

# Mount the first partition and copy the boot files into it
sudo mkdir -p /tmp/mnt
sudo mount -o loop "${LOOPDEV}"p1 /tmp/mnt

# Copy the files into the first partition
sudo cp -r "${BOOTFILESDIR}"/* /tmp/mnt/
sudo cp ${DTBS} /tmp/mnt/
sudo mkdir /tmp/mnt/overlays
for f in $( ls "${IMAGESDIR}"/*.dtbo | grep -v -e "-raspberrypi4-64" )
do
    if [ -L ${f} ]; then
        sudo cp ${f} /tmp/mnt/overlays/
    fi
done
sudo cp ${KERNELIMG} /tmp/mnt/kernel8.img

# Unmount
sudo umount /tmp/mnt

# Mount the ext4 partition
sudo mount -o loop "${LOOPDEV}"p2 /tmp/mnt

# Copy the root fs
if [[ ${RTFS_NAME} == *.xz ]]; then
    sudo tar --numeric-owner -C /tmp/mnt -xJf ${RTFS}
elif [[  ${RTFS_NAME} == *.bz2 ]]; then
    sudo tar --numeric-owner -C /tmp/mnt -xjf ${RTFS}
fi

# Generate random seed for urandom
sudo mkdir -p /tmp/mnt/var/lib/urandom
sudo dd if=/dev/urandom of=/tmp/mnt/var/lib/urandom/random-seed bs=512 count=1
sudo chmod 600 /tmp/mnt/var/lib/urandom/random-seed

# Hostname
echo ${TARGET_HOSTNAME} > hostname
sudo mv hostname /tmp/mnt/etc/hostname

# Unmount
sudo umount /tmp/mnt

# Detach loopback device
sudo losetup --detach ${LOOPDEV}
