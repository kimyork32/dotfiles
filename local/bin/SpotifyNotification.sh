#!/usr/bin/env bash

notify_id=9999
last_track=""

playerctl --player=spotify metadata --format "{{title}}|{{artist}}|{{mpris:artUrl}}" --follow | \
while IFS="|" read -r title artist arturl; do
    
    if [[ -z "$title" ]]; then
        continue
    fi

    current_track="$title - $artist"
    if [[ "$current_track" == "$last_track" ]]; then
        continue
    fi
    last_track="$current_track"

    cover="/tmp/spotify_cover.jpg"

    if [[ "$arturl" == http* ]]; then
        if curl -s -L --max-time 2 "$arturl" -o "$cover"; then
            notify-send -a "Spotify" -u normal -r $notify_id -i "$cover" "$title" "$artist"
        else
            notify-send -a "Spotify" -u normal -r $notify_id -i spotify "$title" "$artist"
        fi
    else
        notify-send -a "Spotify" -u normal -r $notify_id -i spotify "$title" "$artist"
    fi
done
