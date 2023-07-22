#!/bin/sh

# Use brillo to logarithmically adjust laptop screen brightness
# and send a notification displaying the current brightness level after.

# Code thanks to https://youtu.be/pGOaSS8nEQA

send_notification() {
	brightness=$(printf "%.0f\n" "$(brillo -G)")
	dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "brightness-$1" "Brightness: $brightness%" -t 2000
}

case $1 in
up)
	pkexec brillo -u 150000 -A 1 -q
	send_notification "$1"
	;;
down)
	pkexec brillo -u 150000 -U 1 -q
	send_notification "$1"
	;;
esac
