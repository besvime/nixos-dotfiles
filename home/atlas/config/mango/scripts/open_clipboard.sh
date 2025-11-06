#!/usr/bin/env bash
cliphist list | fuzzel --dmenu --width=50 --lines=7 | cliphist decode | wl-copy