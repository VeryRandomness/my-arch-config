#!/bin/bash

# =================================================================
# 1. ERROR CHECKING AND YAY INSTALLATION
# =================================================================

set -e 
# Note: Stow and Git are assumed to be installed by the pre-script/archinstall

# Install prerequisites for yay
echo "Installing prerequisites for building yay..."
# 'base-devel' is a group containing tools like 'makepkg'
sudo pacman -S --needed base-devel --noconfirm

# Check if yay is already installed, if not, install it
if ! command -v yay &> /dev/null
then
    echo "Installing yay (AUR helper)..."
    YAY_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git $YAY_DIR
    (
        cd $YAY_DIR
        makepkg -si --noconfirm
    )
    rm -rf $YAY_DIR
else
    echo "yay is already installed. Skipping installation."
fi

# =================================================================
# 2. INSTALL ALL PACKAGES (PACMAN & YAY)
# =================================================================

echo "Installing Pacman packages (Official Repositories)..."
sudo pacman -S --noconfirm \
  waybar fastfetch obsidian swaync syncthing tailscale \
  kitty nautilus wofi hyprpaper hypridle hyprshot btop \
  spotify-launcher otf-font-awesome --needed 

echo "Installing AUR packages (Arch User Repository) using yay..."
# NOTE: Do NOT use sudo with yay
yay -S --noconfirm \
  sublime-text-4 anydesk-bin brave-bin 

# =================================================================
# 3. DEPLOY DOTFILES WITH STOW
# =================================================================

echo "Deploying configuration files using GNU Stow..."
# Assumes the script is run from the cloned Dotfiles directory
stow */

# =================================================================
# 4. TAILSCALE AND PERMISSIONS SETUP
# =================================================================

echo "Configuring and starting Tailscale service..."
sudo systemctl enable --now tailscaled

echo "Setting necessary execution permissions for scripts..."
# Uses the symlinked paths created by Stow
chmod +x ~/.config/hypr/scripts/Weather.sh
chmod +x ~/.config/hypr/startup.sh
chmod +x ~/.config/hypr/wofi-random-prompt.sh

echo ""
echo "--- SETUP COMPLETE! ---"
echo "1. Tailscale needs you to run 'sudo tailscale up' and follow the link."
echo "2. REBOOT your system to ensure Hyprland starts correctly."
