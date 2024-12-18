#!/bin/bash
fg=c0caf5
wrong=db4b4b
highlight=565f89
date=7aa2f7
verify=008800

slowfade () {
    dis=$(echo -n "$DISPLAY" | tr -c '[:alnum:]' _)
    ifc='com.github.chjj.compton'
    obj='/com/github/chjj/compton'
    if [[ "$1" == "start" ]]; then
        dbus-send --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_in_step double:0.02
        dbus-send --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_out_step double:0.02
    else
        dbus-send --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_in_step double:0.1
        dbus-send --dest=$ifc.$dis \
            $obj $ifc.opts_set string:fade_out_step double:0.1
    fi
}

# Function to get a random wallpaper from the Downloads directory
get_random_wallpaper() {
    # Find image files recursively in the Downloads directory
    find ~/Downloads -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | shuf -n 1
}

pkill -u "$USER" -USR1 dunst
slowfade start
# Get a random wallpaper
WALLPAPER=$(get_random_wallpaper)
i3lock -n --force-clock -i "$WALLPAPER" -t -e \
    --indicator \
    --radius=30 \
    --ring-width=5 \
    --inside-color=80000000 \
    --ring-color=$fg \
    --insidever-color=80000000 \
    --ringver-color=$verify \
    --insidewrong-color=80000000 \
    --ringwrong-color=$wrong \
    --line-uses-inside \
    --keyhl-color=$verify \
    --separator-color=$verify \
    --bshl-color=$verify \
    --time-str="%H:%M" \
    --time-size=140 \
    --date-str="%a, %d %b" \
    --date-size=45 \
    --verif-text="Verifying Password..." \
    --verif-pos="300:680" \
    --wrong-text="Wrong Password!" \
    --noinput-text="" \
    --greeter-text="Senpai Himan ! please open me up, Daddy.." \
    --ind-pos="300:610" \
    --time-font="Sofia Pro:style=Bold" \
    --date-font="Sofia Pro" \
    --verif-font="Sofia Pro" \
    --greeter-font="Sofia Pro" \
    --wrong-font="Sofia Pro" \
    --verif-size=15 \
    --greeter-size=23 \
    --wrong-size=23 \
    --time-pos="300:390" \
    --date-pos="300:450" \
    --greeter-pos="300:780" \
    --wrong-pos="300:820" \
    --verif-pos="300:675" \
    --date-color=$date \
    --time-color=$date \
    --greeter-color=$fg \
    --wrong-color=$wrong \
    --verif-color=$verify \
    --pointer=default \
    --refresh-rate=0 \
    --pass-media-keys \
    --pass-volume-keys
slowfade end
