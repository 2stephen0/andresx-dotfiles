#!/bin/bash

# Ruta a la carpeta con las imágenes de fondo
WALLPAPER_DIR="/home/andresx/Pictures/Wallpapers/wallpapers"
# Archivo de configuración de hyprpaper
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Selecciona una imagen aleatoria de la carpeta
WALLPAPER_PATH=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Verifica si se seleccionó una imagen
if [[ -z "$WALLPAPER_PATH" ]]; then
    echo "No se pudo seleccionar una imagen aleatoria."
    exit 1
fi

# Verifica si el socket de hyprpaper existe
SOCKET_PATH="/run/user/$(id -u)/hypr/$(ls /run/user/$(id -u)/hypr/ | grep .hyprpaper.sock)"

# Pre-carga la imagen
echo "Pre-cargando imagen: $WALLPAPER_PATH"
hyprctl hyprpaper preload "$WALLPAPER_PATH"

# Espera a que se complete la pre-carga
sleep 1

# Aplica el wallpaper usando hyprctl
echo "Aplicando wallpaper: $WALLPAPER_PATH"
hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER_PATH"
hyprctl hyprpaper wallpaper "HDMI-A-1,$WALLPAPER_PATH"

# Verifica el estado del comando anterior
if [[ $? -eq 0 ]]; then
    echo "Wallpaper aplicado con éxito: $WALLPAPER_PATH"
else
    echo "Error al aplicar el wallpaper."
fi

