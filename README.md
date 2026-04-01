# Ubuntu Setup

Automated setup scripts for a fresh Ubuntu installation.

## Quick Start

```bash
./install.sh
```

Select the components you want to install from the interactive menu. Enter numbers separated by spaces, or `7` to install everything.

```
1) curl + git              (prerequisites)
2) Oh My ZSH               (ZSH + Oh My ZSH + set as default shell)
3) NVM                     (requires Oh My ZSH)
4) ZSH Plugins             (autosuggestions, history-search, syntax-highlight)
5) Git Configuration       (global user config)
6) GitHub CLI
7) Install All
```

> Options 3 and 4 require Oh My ZSH to be installed first (option 2).

---

## Scripts

| Script                           | Description                                            |
| -------------------------------- | ------------------------------------------------------ |
| `scripts/install-curl-git.sh`    | Installs curl and git                                  |
| `scripts/install-ohmyzsh.sh`     | Installs ZSH, Oh My ZSH, and sets ZSH as default shell |
| `scripts/install-nvm.sh`         | Installs NVM and adds it to `.zshrc`                   |
| `scripts/install-zsh-plugins.sh` | Clones and activates ZSH plugins                       |
| `scripts/install-git-config.sh`  | Applies global git configuration                       |
| `scripts/install-gh-cli.sh`      | Installs GitHub CLI via apt                            |

Each script can also be run individually:

```bash
bash scripts/install-ohmyzsh.sh
```

---

## References

- [nvm-sh/nvm](https://github.com/nvm-sh/nvm)
- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [GitHub CLI install docs](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
