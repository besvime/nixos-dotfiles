#!/usr/bin/env sh

set -e

# Start Polkit GNOME authentication agent
(sleep 2 && /nix/store/w8h0097yqh767gigdig05ydcbf51qc0y-polkit-gnome-0.105/libexec/polkit-gnome-authentication-agent-1) &

# Set Wallpaper (SWW)
swww-daemon & 

sleep 2 

swww img ~/nixos-dotfiles/assets/wallpapers/mountain.jpg

# Set Waybar
waybar

# Set Mako
mako