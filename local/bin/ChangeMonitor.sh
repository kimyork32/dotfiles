#!/bin/bash

# Habilitar modo de depuración
set -x

# Obtener la posición actual del cursor
eval $(xdotool getmouselocation --shell)

# Obtener información de los monitores
IFS=$'\n' read -d '' -r -a monitors < <(xrandr --listmonitors | tail -n +2)

# Extraer información del primer monitor (HDMI-1)
monitor0_width=$(echo "${monitors[0]}" | awk -F'[x/+]' '{print $1}' | sed 's/[^0-9]//g')
monitor0_offset_x=$(echo "${monitors[0]}" | awk -F'[x/+]' '{print $4}' | sed 's/[^0-9]//g')

# Extraer información del segundo monitor (eDP-1)
monitor1_width=$(echo "${monitors[1]}" | awk -F'[x/+]' '{print $1}' | sed 's/[^0-9]//g')
monitor1_offset_x=$(echo "${monitors[1]}" | awk -F'[x/+]' '{print $4}' | sed 's/[^0-9]//g')

# Imprimir valores para depuración
echo "Monitor 0 width: $monitor0_width"
echo "Monitor 0 offset X: $monitor0_offset_x"
echo "Monitor 1 width: $monitor1_width"
echo "Monitor 1 offset X: $monitor1_offset_x"
echo "Current X: $X"
echo "Current Y: $Y"

# Verificar que los valores sean números
if [[ ! $monitor0_width =~ ^[0-9]+$ ]] || 
   [[ ! $monitor0_offset_x =~ ^[0-9]+$ ]] || 
   [[ ! $monitor1_width =~ ^[0-9]+$ ]] || 
   [[ ! $monitor1_offset_x =~ ^[0-9]+$ ]]; then
    echo "Error: No se pudieron obtener valores numéricos válidos"
    exit 1
fi

# Determinar en qué monitor estamos basado en la posición X absoluta
if [[ $X -lt $monitor1_offset_x ]]; then
    # Estamos en HDMI-1, mover a eDP-1
    target_x=$((monitor1_offset_x + (monitor1_width / 2)))
    target_y=$Y
    xdotool mousemove $target_x $target_y
else
    # Estamos en HDMI-1, mover a eDP-1
    target_x=$((monitor0_offset_x + (monitor0_width / 2)))
    target_y=$Y
    xdotool mousemove $target_x $target_y
fi
