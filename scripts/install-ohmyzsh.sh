#!/bin/bash
set -e

echo "Installing ZSH..."
sudo apt update
sudo apt install -y zsh

echo "Installing Oh My ZSH..."
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting ZSH as default shell..."
chsh -s "$(which zsh)"

echo "Oh My ZSH installed. Run 'exec zsh' to start using it."
