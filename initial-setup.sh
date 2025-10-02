#!/bin/bash

# =================================================================
# Initial Setup (Clones the repo and runs the main script)
# =================================================================

set -e 

REPO_URL="https://github.com/VeryRandomness/my-arch-config.git"
INSTALL_DIR="$HOME/Dotfiles"

echo "--- STARTING AUTOMATED ARCH CONFIGURATION ---"

# We must ensure 'git' and 'stow' are available before cloning and running the install script
echo "Installing essential utilities: sudo and git and stow..."
pacman -Syu --noconfirm sudo
sudo pacman -S --needed git stow --noconfirm

# Clone the repository
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Cloning dotfiles repository to $INSTALL_DIR"
    git clone $REPO_URL $INSTALL_DIR
else
    echo "Dotfiles directory $INSTALL_DIR already exists. Skipping clone."
fi

# Change directory and execute the main install script
echo "Executing the main install script (install.sh)..."
cd $INSTALL_DIR
if [ -f "install.sh" ]; then
    bash ./install.sh
else
    echo "Error: Main install script (install.sh) not found in repository."
    exit 1
fi
