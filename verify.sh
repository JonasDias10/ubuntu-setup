#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

FAILS=0

check() {
    local desc="$1"
    shift
    if "$@" >/dev/null 2>&1; then
        echo -e "${GREEN}[OK]${NC}   $desc"
    else
        echo -e "${RED}[FAIL]${NC} $desc"
        FAILS=$((FAILS + 1))
    fi
}

check_eq() {
    local desc="$1" expected="$2" actual="$3"
    if [ "$expected" = "$actual" ]; then
        echo -e "${GREEN}[OK]${NC}   $desc"
    else
        echo -e "${RED}[FAIL]${NC} $desc (expected '$expected', got '$actual')"
        FAILS=$((FAILS + 1))
    fi
}

echo -e "${YELLOW}== curl + git ==${NC}"
check "curl is installed"    command -v curl
check "git is installed"     command -v git

echo -e "${YELLOW}== Oh My ZSH ==${NC}"
check "zsh is installed"           command -v zsh
check "~/.oh-my-zsh exists"        [ -d "$HOME/.oh-my-zsh" ]
check_eq "zsh is the default shell" "$(which zsh)" "$(getent passwd "$(whoami)" | cut -d: -f7)"

echo -e "${YELLOW}== NVM ==${NC}"
check "~/.nvm/nvm.sh exists"       [ -s "$HOME/.nvm/nvm.sh" ]
check "NVM_DIR configured in .zshrc" grep -q 'NVM_DIR' "$HOME/.zshrc"

echo -e "${YELLOW}== ZSH Plugins ==${NC}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
for plugin in zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting; do
    check "$plugin cloned"           [ -d "$ZSH_CUSTOM/plugins/$plugin" ]
    check "$plugin enabled in .zshrc" grep -qE "plugins=\(.*$plugin" "$HOME/.zshrc"
done

echo -e "${YELLOW}== Git Configuration ==${NC}"
check_eq "user.name"        "Jonas Dias"          "$(git config --global user.name)"
check_eq "user.email"       "zdias1413@gmail.com" "$(git config --global user.email)"
check_eq "init.defaultBranch" "main"              "$(git config --global init.defaultBranch)"
check_eq "oh-my-zsh.hide-info" "1"                "$(git config --global oh-my-zsh.hide-info)"

echo -e "${YELLOW}== GitHub CLI ==${NC}"
check "gh is installed" command -v gh

echo ""
if [ "$FAILS" -eq 0 ]; then
    echo -e "${GREEN}All checks passed.${NC}"
    exit 0
else
    echo -e "${RED}$FAILS check(s) failed.${NC}"
    exit 1
fi
