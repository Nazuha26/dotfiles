# Linux Dotfiles

Just config files for some programs that I actively use.

## Requirements

- git
- stow
- zsh
- starship
- micro

## Installation

Follow these steps to download and apply the settings:

1. Open your terminal.
2. Clone this repository:
   
   ```bash
   git clone https://github.com/Nazuha26/linux-dotfiles.git ~/.dotfiles
   ```
3. Go into the new folder:
   ```bash
   cd ~/.dotfiles
   ```
4. Use Stow to create the symbolic links for the programs you want:
   ```bash
   stow zsh bash git starship micro
   ```
   OR apply all configs at once:
   ```bash
   stow *
   ```

## Post-Installation

Install these Zsh plugins so the `.zshrc` file works correctly:

```bash
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
