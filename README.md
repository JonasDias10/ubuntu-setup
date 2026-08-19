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

## Testing in Docker

The scripts modify your shell, your git globals and your system packages, so it is safer to try them in an isolated container first instead of running them directly on your machine.

```bash
./docker-test.sh
```

This builds a throwaway Ubuntu 24.04 image, runs `install.sh` with every component selected, then runs `verify.sh` to confirm the final state. Nothing in the container touches the host.

| File              | Purpose                                                         |
| ----------------- | --------------------------------------------------------------- |
| `Dockerfile.test` | Defines the sandbox image, a plain Ubuntu user with sudo access |
| `docker-test.sh`  | Builds the image and runs install plus verify in one command    |
| `verify.sh`       | Confirms curl, git, zsh, Oh My ZSH, NVM, plugins and git config |

You can also run a single script inside the sandbox for a quicker check:

```bash
docker build -f Dockerfile.test -t ubuntu-setup-test .
docker run --rm -it ubuntu-setup-test
```

That drops you into a shell inside the container, from which you can run `./install.sh` or any script under `scripts/` by hand.

---

## 📌 Fix: Brightness Not Working (Ubuntu + Ryzen + NVIDIA RTX)

On some laptops with Ryzen CPUs and NVIDIA RTX GPUs, the brightness slider may appear but not actually change the screen brightness.

### 🔧 Quick Fix

1. Open the GRUB configuration file:

```bash
sudo nano /etc/default/grub
```

2. Find this line:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```

3. Replace it with:

```bash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_backlight=native"
```

4. Update GRUB:

```bash
sudo update-grub
```

5. Reboot your system:

```bash
sudo reboot
```

---

## References

- [nvm-sh/nvm](https://github.com/nvm-sh/nvm)
- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [GitHub CLI install docs](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
