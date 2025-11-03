#!/usr/bin/env sh

set -e

# Start Polkit GNOME authentication agent
(sleep 2 && /nix/store/w8h0097yqh767gigdig05ydcbf51qc0y-polkit-gnome-0.105/libexec/polkit-gnome-authentication-agent-1) &

# Set wallpaper
swww-daemon & sleep 1 && swww img ~/nixos-dotfiles/assets/wallpapers/mountain.jpg