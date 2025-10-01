#!/bin/bash

waybar &
hyprpaper &
hypridle &
hyprshot &
syncthing &

sleep 2
swaync &

Sleep 118
~/dotfiles/.config/hypr/scripts/update_check.sh
