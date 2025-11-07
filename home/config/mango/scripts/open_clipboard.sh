#!/usr/bin/env bash
cliphist list | fuzzel --dmenu --width=50 --lines=7 --anchor=top-right --x-margin=4 | cliphist decode | wl-copy