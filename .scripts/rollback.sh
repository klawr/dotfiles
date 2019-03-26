#!/bin/bash
# System Rollback
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
REFLECTOR=/usr/bin/reflector

# --------------------------
#      Rollback System
# --------------------------

# ------- TESTING --------
$SUDO $BTRFS subvolume delete /.snapshots/TESTING
$SUDO $BTRFS subvolume snapshot / /.snapshots/TESTING
$SUDO $SED -i 's/STABLE/TESTING/g' /.snapshots/TESTING/etc/fstab
$SUDO $CP /boot/vmlinuz-linux-stable /boot/vmlinuz-linux
$SUDO $CP /boot/initramfs-linux-stable.img /boot/initramfs-linux.img
