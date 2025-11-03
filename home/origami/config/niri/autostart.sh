#!/usr/bin/env bash
sleep 1

(sleep 2 && /nix/store/.../polkit-gnome-authentication-agent-1) &
swaybg -i ~/nixos-dotfiles/assets/wallpapers/mountain.jpg -m fill &
waybar &
mako &
alacritty &
swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f' &
