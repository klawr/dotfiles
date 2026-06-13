#!/bin/bash
# Wait for kwalletd6 to be ready on D-Bus
until dbus-send --session --print-reply --dest=org.freedesktop.DBus \
    /org/freedesktop/DBus org.freedesktop.DBus.GetNameOwner \
    string:org.kde.kwalletd6 &>/dev/null; do
    sleep 0.2
done

nextcloud --background
