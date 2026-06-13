#!/bin/bash
# Wait for kwalletd6 to be ready on D-Bus
until dbus-send --session --print-reply --dest=org.freedesktop.DBus \
    /org/freedesktop/DBus org.freedesktop.DBus.GetNameOwner \
    string:org.kde.kwalletd6 &>/dev/null; do
    sleep 0.2
done

# Start Tutanota
tutanota-desktop &

# Wait for its window to appear, then move it to special workspace
until hyprctl clients -j | grep -q tutanota; do
    sleep 0.2
done
hyprctl dispatch movetoworkspacesilent "12,class:^(tutanota-desktop)$"
