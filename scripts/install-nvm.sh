#!/bin/bash
set -e

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Error: Oh My ZSH must be installed before NVM. Run install-ohmyzsh.sh first."
    exit 1
fi

echo "Installing NVM v0.40.4..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# Add NVM exports to .zshrc if not already present
ZSHRC="$HOME/.zshrc"
if ! grep -q 'NVM_DIR' "$ZSHRC"; then
    echo "" >> "$ZSHRC"
    echo "# NVM" >> "$ZSHRC"
    echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> "$ZSHRC"
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$ZSHRC"
    echo "NVM configuration added to .zshrc"
else
    echo "NVM already configured in .zshrc"
fi

echo "NVM installed. Restart your terminal or run 'exec zsh' to use it."
