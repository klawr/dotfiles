#!/bin/bash

# Script to update btrfs

# System Update
# ---------------------------
# Snapshot - Rollback - Btrfs
# ---------------------------

SUDO=/usr/bin/sudo
MV=/usr/bin/mv
BTRFS=/usr/bin/btrfs
MOUNT=/usr/bin/mount
UMOUNT=/usr/bin/umount
SED=/usr/bin/sed
PACMAN=/usr/bin/pacman
CP=/usr/bin/cp

# --------------------------
#      Snapshot System
# --------------------------

# ------- OLDSTABLE --------
$SUDO $BTRFS subvolume delete /.snapshots/OLDSTABLE
$SUDO $MV /.snapshots/STABLE /.snapshots/OLDSTABLE
$SUDO $SED -i 's/STABLE/OLDSTABLE/g' /.snapshots/OLDSTABLE/etc/fstab
$SUDO $CP /boot/vmlinuz-linux-stable /boot/vmlinuz-linux-oldstable
$SUDO $CP /boot/initramfs-linux-stable.img /boot/initramfs-linux-oldstable.img

# -------- STABLE ----------

$SUDO $BTRFS subvolume snapshot / /.snapshots/STABLE
$SUDO $SED -i 's/TESTING/STABLE/g' /.snapshots/STABLE/etc/fstab
$SUDO $CP /boot/vmlinuz-linux /boot/vmlinuz-linux-stable
$SUDO $CP /boot/initramfs-linux.img /boot/initramfs-linux-stable.img

# --------------------------
#        Update System
# --------------------------

$PACMAN -Syu
