#!/bin/bash
set -e

echo "Installing ZSH..."
sudo apt update
sudo apt install -y zsh

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My ZSH already installed, skipping."
else
    echo "Installing Oh My ZSH..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ "$(getent passwd "$(whoami)" | cut -d: -f7)" != "$(which zsh)" ]; then
    echo "Setting ZSH as default shell..."
    chsh -s "$(which zsh)"
else
    echo "ZSH is already the default shell."
fi

echo "Oh My ZSH installed. Run 'exec zsh' to start using it."
