# Ubuntu Setup - Manual Reference

Manual commands for each component. For automated installation see [README.md](README.md).

---

## Prerequisites - curl + git

```bash
sudo apt update
sudo apt install -y curl git
```

---

## ZSH + Oh My ZSH

### Install ZSH

```bash
sudo apt update
sudo apt install -y zsh
```

### Install Oh My ZSH

Repository: [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Set ZSH as default shell

```bash
chsh -s $(which zsh)
exec zsh
```

### Recommended Plugins

> Clone into `${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/` then add to `plugins=(...)` in `~/.zshrc`.

**Autosuggestions** - [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

**History Substring Search** - [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)

```bash
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```

**Syntax Highlighting** - [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Update `~/.zshrc`:

```
plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
```

---

## NVM (Node Version Manager)

Repository: [nvm-sh/nvm](https://github.com/nvm-sh/nvm)

> Install after Oh My ZSH so the exports are added to `.zshrc`.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
```

Add to `~/.zshrc` if not added automatically:

```bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

---

## Git - Global Configuration

```bash
git config --global user.name "Jonas Dias"
git config --global user.email "zdias1413@gmail.com"
git config --global init.defaultBranch main
git config --global --add oh-my-zsh.hide-info 1
```

---

## GitHub CLI

Documentation: [cli/cli](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)

```bash
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
    && sudo mkdir -p -m 755 /etc/apt/keyrings \
    && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
```

Authenticate after install:

```bash
gh auth login
```
