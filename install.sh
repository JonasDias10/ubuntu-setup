#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS="$SCRIPT_DIR/scripts"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║           Ubuntu Setup Installer          ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

ohmyzsh_available() {
    [ -d "$HOME/.oh-my-zsh" ]
}

print_menu() {
    echo -e "${YELLOW}Available components:${NC}"
    echo ""
    echo -e "  ${CYAN}1)${NC} curl + git              ${BLUE}(prerequisites)${NC}"
    echo -e "  ${CYAN}2)${NC} Oh My ZSH               ${BLUE}(ZSH + Oh My ZSH + set as default shell)${NC}"
    echo -e "  ${CYAN}3)${NC} NVM                     ${BLUE}(requires Oh My ZSH)${NC}"
    echo -e "  ${CYAN}4)${NC} ZSH Plugins             ${BLUE}(autosuggestions, history-search, syntax-highlight - requires Oh My ZSH)${NC}"
    echo -e "  ${CYAN}5)${NC} Git Configuration       ${BLUE}(global user config)${NC}"
    echo -e "  ${CYAN}6)${NC} GitHub CLI"
    echo -e "  ${CYAN}7)${NC} Install All"
    echo ""

    if ohmyzsh_available; then
        echo -e "  ${GREEN}Oh My ZSH is already installed.${NC}"
    else
        echo -e "  ${YELLOW}Oh My ZSH is not installed yet - options 3 and 4 require it.${NC}"
    fi

    echo ""
}

run_script() {
    local script="$1"
    local name="$2"
    echo -e "\n${GREEN}>>> Installing: $name${NC}"
    bash "$script"
    echo -e "${GREEN}>>> Done: $name${NC}"
}

validate_selections() {
    local -n sel=$1
    local ohmyzsh_will_install="${sel[2]:-}"

    if [[ "${sel[3]:-}" == "1" ]] && [[ "$ohmyzsh_will_install" != "1" ]] && ! ohmyzsh_available; then
        echo -e "${RED}Error: NVM requires Oh My ZSH. Include option 2, or install Oh My ZSH first.${NC}"
        return 1
    fi

    if [[ "${sel[4]:-}" == "1" ]] && [[ "$ohmyzsh_will_install" != "1" ]] && ! ohmyzsh_available; then
        echo -e "${RED}Error: ZSH Plugins require Oh My ZSH. Include option 2, or install Oh My ZSH first.${NC}"
        return 1
    fi

    return 0
}

main() {
    print_header
    print_menu

    echo -ne "${CYAN}Select options (e.g.: 1 2 3  or  7 for all): ${NC}"
    read -r input

    declare -A selected

    for num in $input; do
        selected[$num]=1
    done

    if [[ "${selected[7]:-}" == "1" ]]; then
        for i in 1 2 3 4 5 6; do
            selected[$i]=1
        done
    fi

    if [[ ${#selected[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No option selected. Exiting.${NC}"
        exit 0
    fi

    validate_selections selected || exit 1

    echo ""
    echo -e "${YELLOW}Starting installation...${NC}"

    [[ "${selected[1]:-}" == "1" ]] && run_script "$SCRIPTS/install-curl-git.sh"    "curl + git"
    [[ "${selected[2]:-}" == "1" ]] && run_script "$SCRIPTS/install-ohmyzsh.sh"     "Oh My ZSH"
    [[ "${selected[3]:-}" == "1" ]] && run_script "$SCRIPTS/install-nvm.sh"         "NVM"
    [[ "${selected[4]:-}" == "1" ]] && run_script "$SCRIPTS/install-zsh-plugins.sh" "ZSH Plugins"
    [[ "${selected[5]:-}" == "1" ]] && run_script "$SCRIPTS/install-git-config.sh"  "Git Configuration"
    [[ "${selected[6]:-}" == "1" ]] && run_script "$SCRIPTS/install-gh-cli.sh"      "GitHub CLI"

    echo ""
    echo -e "${GREEN}Setup complete! Restart your terminal or run: exec zsh${NC}"
}

main
