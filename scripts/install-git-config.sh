#!/bin/bash
set -e

echo "Configuring git globals..."
git config --global user.name "Jonas Dias"
git config --global user.email "zdias1413@gmail.com"
git config --global init.defaultBranch main
git config --global --add oh-my-zsh.hide-info 1
echo "Git configured successfully."
