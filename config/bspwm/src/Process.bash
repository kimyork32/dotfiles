if pgrep -x polybar > /dev/null; then
    polybar-msg cmd quit
elif pgrep -f "eww.*bar" > /dev/null; then
    pkill -f "eww.*bar"
fi

pkill -x dunst

if pgrep -f "bspc subscribe node_state" > /dev/null; then
    pkill -f "bspc subscribe node_state"
fi
sleep 0.30
