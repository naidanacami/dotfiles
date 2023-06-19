#!/usr/bin/env bash
sleep 1
store_wallpaper="/home/nicho/.config/scripts/wallpaper_scripts/current_wallpaper.txt"

wallpaper=$(cat $store_wallpaper)
feh --bg-fill $wallpaper
betterlockscreen -u $wallpaper
