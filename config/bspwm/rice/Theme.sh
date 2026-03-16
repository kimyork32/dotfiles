#Theme.sh


# ====== KILL PROCESS ==============================================

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

# ====== CONFIGURATION =============================================

export grisb="#353c52"
export black="#000000"
export green="#61b33e"

set_bspwm_config() {
	bspc config border_width 		1
	bspc config window_gap 			0
	bspc config top_padding 		0
	bspc config bottom_padding 		0
	bspc config left_padding 		0
	bspc config right_padding 		0
	bspc config normal_border_color	"${grisb}"
	bspc config active_border_color	"${green}"
	bspc config focused_border_color "${green}"
}

launch_polybar() {
	sleep 0.1
	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		(MONITOR=$mon polybar -q dark -c "${HOME}"/.config/bspwm/rice/config.ini) &
	done
}

set_bspwm_config
launch_polybar
