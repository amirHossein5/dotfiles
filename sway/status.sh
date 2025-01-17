date_formatted=$(date +'%Y-%m-%d %I:%M:%S %p')

battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

audio_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5;exit}')
audio_status=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2=="no" ? "" : "(muted)"}')

brightness_level=$(echo $(cat /sys/class/backlight/intel_backlight/actual_brightness)"*100/"$(cat /sys/class/backlight/intel_backlight/max_brightness) | bc)%

echo 'brightness' $brightness_level '| vol' $audio_volume $audio_status  '|' $battery_capacity'% ('$battery_status')' '|' $date_formatted
