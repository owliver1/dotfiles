#!/bin/zsh

# Directories
THEMES_DIR="$HOME/.config/themes"
WAYBAR_DIR="$HOME/.config/waybar"
FUZZEL_DIR="$HOME/.config/fuzzel"
KITTY_DIR="$HOME/.config/kitty"
SWAY_DIR="$HOME/.config/sway"
DUNST_DIR="$HOME/.config/dunst"

# List only directories in $THEMES_DIR
themes=($(find "$THEMES_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

# Debugging: Print available themes
printf "Debug: Themes available for selection:\n%s\n" "${themes[@]}"

# Check if any themes are available
if [[ ${#themes[@]} -eq 0 ]]; then
    echo "No themes found in $THEMES_DIR. Exiting."
    exit 1
fi

# Use Fuzzel to select a theme
selected_theme=$(printf "%s\n" "${themes[@]}" | fuzzel --dmenu --prompt "Select Theme:")

# Exit if no theme is selected
if [[ -z "$selected_theme" ]]; then
    echo "No theme selected. Exiting."
    exit 1
fi

# Ensure the selected theme exists
if [[ ! -d "$THEMES_DIR/$selected_theme" ]]; then
    echo "Error: Theme '$selected_theme' does not exist"
    exit 1
fi

# Apply configurations
echo "Switching to theme: $selected_theme"

ln -sf "$THEMES_DIR/$selected_theme/waybar/config" "$WAYBAR_DIR/config"
ln -sf "$THEMES_DIR/$selected_theme/waybar/style.css" "$WAYBAR_DIR/style.css"
ln -sf "$THEMES_DIR/$selected_theme/fuzzel/fuzzel.ini" "$FUZZEL_DIR/fuzzel.ini"
ln -sf "$THEMES_DIR/$selected_theme/kitty/kitty.conf" "$KITTY_DIR/kitty.conf"
ln -sf "$THEMES_DIR/$selected_theme/sway/theme" "$SWAY_DIR/theme"
ln -sf "$THEMES_DIR/$selected_theme/dunst/dunstrc" "$DUNST_DIR/dunstrc"

# Reload applications
pkill -SIGUSR1 waybar
swaymsg reload
pkill dunst && dunst &

echo "Theme '$selected_theme' applied successfully."

