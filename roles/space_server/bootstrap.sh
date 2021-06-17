#!/bin/bash
#
# This script assumes filesystems and syslinux are already
# set up. If not here is a short, incomplete guide:
#
# Create a gpt partition table similar to this:
# Disk /dev/sda: 14,9 GiB, 16013942784 bytes, 31277232 sectors
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: gpt
# Disk identifier: 45AA3BC2-C3B8-B24D-A5AF-59C9F2577554
#
# Device       Start      End  Sectors  Size Type
# /dev/sda1     2048  1048575  1046528  511M EFI System
# /dev/sda2  1048576 31277198 30228623 14,4G Linux filesystem
#
# Create boot filesystem:
# mkfs.vfat -v -F32 -n BOOT /dev/sda1
#
# Create root filesystem:
# mkfs.btrfs -m single -d single -L BTRFS /dev/sda2
#
# Install syslinux:
# mount -o noatime,fmask=0133,dmask=0022,utf8 /dev/sda1 /boot
# mkdir /boot/syslinux
# syslinux -d syslinux -i /dev/sda1
# cp /usr/share/syslinux/{libutil,menu}.c32 /boot/syslinux/
# dd bs=440 count=1 if=/usr/share/syslinux/gptmbr.bin of=/dev/sda
#
# Mount root filesystem:
# mount -o noatime,ssd,compress=lzo /dev/sda2 /mnt
#
# Create and mount home subvolume:
# btrfs subvolume create /mnt/home
# mount -o noatime,ssd,compress=lzo,subvol=/home /dev/sda2 /home
#
# Run this script
# ./roles/space_server/bootstrap.sh

set -e
set -x

release=33
dest="/mnt/fedora$release"
secrets='./secrets.yml'
if [[ -e "$dest" ]]; then
  echo "Destination '$dest' already exists. Aborting." >&2
  exit 1
fi

btrfs subvolume create "$dest"
chmod 0755 "$dest"

dnf \
  --assumeyes \
  --setopt=install_weak_deps=False \
  --installroot="$dest" \
  --releasever=$release \
  --disablerepo='*' \
  --enablerepo=fedora \
  --enablerepo=updates \
  install glibc-langpack-en systemd-udev dnf git ansible

for i in /var/lib/machines /var/lib/portables; do
  if [[ -d "$dest$i" ]]; then
    btrfs subvolume delete "$dest$i"
  fi
  echo "Creating $i"
  install -o root -g root -m755 -d "$dest$i"
done

if [[ -f "$secrets" ]]; then
  install -o root -g root -m600 "$secrets" "$dest/root/secrets.yml"
fi

exec systemd-nspawn \
  -D "$dest" \
  -M space.labitat.dk \
  -E ANSIBLE_FORCE_COLOR=1 \
  --bind /boot \
  --bind /home \
  -- \
  ansible-pull \
    -i space.labitat.dk, \
    -c local \
    -U 'https://github.com/labitat/labitat-ansible.git' \
    -d /root/ansible \
    space.yml

# vim: set ts=2 sw=2 et:
