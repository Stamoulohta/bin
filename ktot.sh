#!/usr/bin/env bash
# vim: set fileencoding=utf-8 :
#======================================================================================================================#
#
# Keep Track of Time
# Shows a desktop notification every one hour.
# I wrote it to help me with my procastination issues
# while I was supposed to be working.
#
#======================================================================================================================#

interval="1h"

tempdir="$HOME/temp"
pid="$tempdir/ktot.pid"
icon="/usr/share/icons/Adwaita/32x32/apps/preferences-system-time-symbolic.symbolic.png"
endpoint="http://quotes.stormconsultancy.co.uk/random.json"

if [[ "$XDG_CURRENT_DESKTOP" = "GNOME" ]]; then
    gnome_urgency="--urgency=critical"
fi;

mkdir --parents "$tempdir"

if [[ -f "$pid" ]]; then
    pkill --pidfile "$pid" &> /dev/null
    rm --force "$pid"
    echo "killing ktot"
    exit
fi

echo "starting ktot"

counter=0

while true
do
    let counter++
    sleep "$interval"

    json=$(curl --silent "$endpoint")

    if [[ $json =~ \"author\":\"([^\"]+?)\"[^quote]+quote\":\"([^\"]+?)\" ]]; then
        quote=${BASH_REMATCH[2]}
        author=${BASH_REMATCH[1]}
    else
        quote="It's hard writing a script that works!"
        author="Stamoulohta"
    fi

    notify-send $gnome_urgency --expire-time=0 --icon="$icon" "$counter hours passed!" "$(echo -en "\n$quote\n\n$author")"

done & echo $! > "$pid"
