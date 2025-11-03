#!/usr/bin/env sh

set -e

# Start Polkit GNOME authentication agent
(sleep 2 && /nix/store/w8h0097yqh767gigdig05ydcbf51qc0y-polkit-gnome-0.105/libexec/polkit-gnome-authentication-agent-1) &

# Set Wallpaper (Swaybg)
swaybg -i ~/nixos-dotfiles/assets/wallpapers/mountain.jpg -m fill &

# Set Waybar
waybar &

# Set Mako
mako &

# Spawn base Terminal
alacritty &

# Set Screenlocking & idle
sway-audio-idle-inhibit &
swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'