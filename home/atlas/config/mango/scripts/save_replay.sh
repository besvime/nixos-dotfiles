#!/usr/bin/env bash
pkill -SIGUSR1 -f gpu-screen-recorder & notify-send "Last 5 minutes saved" "Your replay has been saved."