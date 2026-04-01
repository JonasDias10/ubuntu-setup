# 🐧 Ubuntu Setup

## NVM (Node Version Manager)

- Repository: https://github.com/nvm-sh/nvm

---

## ZSH + Oh My ZSH

### Install ZSH

```bash
sudo apt update
sudo apt install zsh
````

* Oh My ZSH Repository: [https://github.com/ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

### Recommended Plugins

* Autosuggestions
  [https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

* History Substring Search
  [https://github.com/zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

* Syntax Highlighting
  [https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

---

## Git

### Global Configuration

```bash
git config --global user.name "Jonas Dias"
git config --global user.email "zdias1413@gmail.com"
git config --global init.defaultBranch main
git config --global --add oh-my-zsh.hide-info 1
```

---

## GitHub CLI

* Documentation:
  [https://github.com/cli/cli/blob/trunk/docs/install_linux.md](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)

---

## Post-installation

### Set ZSH as default shell

```bash
chsh -s $(which zsh)
```

### Reload terminal

```bash
exec zsh
```
