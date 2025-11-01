#!/usr/bin/env bash

SOTERIA="/run/current-system/sw/bin/soteria"
MAKO="/run/current-system/sw/bin/mako"
XWAYLAND="/run/current-system/sw/bin/xwayland-satellite"

run_once() {
    if ! pgrep -x "$(basename "$1")" >/dev/null 2>&1; then
        "$@" &
    fi
}

# --- Autostart programs ---
run_once "$SOTERIA"
run_once "$MAKO"
run_once "$XWAYLAND"
