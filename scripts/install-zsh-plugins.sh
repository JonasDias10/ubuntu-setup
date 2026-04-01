#!/bin/bash
set -e

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Error: Oh My ZSH must be installed before ZSH plugins. Run install-ohmyzsh.sh first."
    exit 1
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSHRC="$HOME/.zshrc"

install_plugin() {
    local name="$1"
    local repo="$2"
    local dir="$ZSH_CUSTOM/plugins/$name"

    if [ ! -d "$dir" ]; then
        echo "Installing $name..."
        git clone "$repo" "$dir"
    else
        echo "$name already installed, skipping."
    fi

    if ! grep -qE "plugins=\(.*$name" "$ZSHRC"; then
        sed -i "s/^plugins=(\(.*\))/plugins=(\1 $name)/" "$ZSHRC"
        echo "Added $name to plugins in .zshrc"
    else
        echo "$name already in .zshrc plugins."
    fi
}

install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_plugin "zsh-history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search"
install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"

echo "ZSH plugins installed. Run 'exec zsh' to activate them."
