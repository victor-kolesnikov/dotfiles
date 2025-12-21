# Dotfiles

Personal dotfiles repository managed with GNU Stow. This collection includes configurations for various tools and applications, with special focus on i3 window manager, zsh shell, conda, and alacritty terminal.

## Overview

This repository contains configuration files for:

- **i3** - Tiling window manager with multi-environment support (Tower-5810 PC, Laptop, WSL)
- **zsh** - Shell configuration with Oh My Zsh integration
- **conda** - Conda package manager configuration
- **alacritty** - Terminal emulator configuration
- **polybar** - Status bar for i3
- **nvim** - Neovim editor configuration
- **starship** - Cross-shell prompt
- **tmux** - Terminal multiplexer
- **rofi** - Application launcher
- And other tools...

## Prerequisites

Before installing these dotfiles, ensure you have:

- **GNU Stow** - For symlink management
  ```bash
  # Debian/Ubuntu
  sudo apt install stow
  
  # Arch Linux
  sudo pacman -S stow
  
  # macOS (with Homebrew)
  brew install stow
  ```

- **i3** (if using i3 configuration)
  ```bash
  sudo apt install i3 i3-gaps polybar rofi feh picom
  ```

- **zsh** (if using zsh configuration)
  ```bash
  sudo apt install zsh
  ```

- **conda/miniforge** (if using conda configuration)
  - Install from [Miniforge](https://github.com/conda-forge/miniforge) or [Anaconda](https://www.anaconda.com/)

- **alacritty** (if using alacritty configuration)
  ```bash
  sudo apt install alacritty
  ```

## Installation

### Quick Start - Install All Dotfiles

```bash
# Clone the repository
git clone <repository-url> ~/dotfiles
cd ~/dotfiles

# Install all configurations
stow */
```

This will create symlinks from your home directory to the configuration files in this repository.

### Selective Installation

You can install specific packages individually:

```bash
# Install only i3 configuration
stow i3

# Install i3, zsh, conda, and alacritty
stow i3 zsh conda alacritty

# Install multiple packages
stow i3 zsh conda alacritty polybar screenlayout
```

### Installation with Target Directory

If you want to install to a different directory (useful for testing):

```bash
stow -t ~/test-home i3 zsh
```

### Uninstalling

To remove symlinks (without deleting the actual files):

```bash
# Remove all
stow -D */

# Remove specific package
stow -D i3
```

## Package-Specific Setup

### i3 Window Manager

The i3 configuration includes **multi-environment support** that automatically detects your system:

- **Tower-5810 PC**: 4-monitor setup with workspace assignments
- **Laptop**: Single monitor configuration
- **WSL**: Minimal setup without monitor-specific configurations

#### Environment Detection

The configuration automatically detects the environment based on:
- Hostname (tower-5810 → tower)
- WSL detection (`/proc/version` or `$WSL_DISTRO_NAME`)
- Defaults to laptop for other cases

#### Manual Environment Override

If you need to manually set the environment, you can modify `~/.config/i3/detect-env.sh` or create a symlink:

```bash
# Force tower configuration
ln -sf ~/.config/i3/env-configs/tower.conf ~/.config/i3/env-configs/active.conf

# Force laptop configuration
ln -sf ~/.config/i3/env-configs/laptop.conf ~/.config/i3/env-configs/active.conf

# Force WSL configuration
ln -sf ~/.config/i3/env-configs/wsl.conf ~/.config/i3/env-configs/active.conf
```

#### i3 Setup Steps

1. Install i3 and dependencies:
   ```bash
   sudo apt install i3 i3-gaps polybar rofi feh picom xss-lock i3lock
   ```

2. Install the i3 configuration:
   ```bash
   stow i3 polybar screenlayout rofi picom
   ```

3. Install required fonts (MesloLGS Nerd Font):
   ```bash
   # Download from https://www.nerdfonts.com/font-downloads
   # Or use your system's font manager
   ```

4. Set up background images:
   ```bash
   mkdir -p ~/backgrounds
   # Add your background images to ~/backgrounds/
   ```

5. Reload i3 configuration:
   - Press `Mod+Shift+R` in i3, or
   - Run `i3-msg reload`

#### i3 Key Bindings

- `Mod` = Super/Windows key
- `Mod+Return` - Open terminal (alacritty)
- `Mod+d` - Application launcher (rofi)
- `Mod+Shift+q` - Close window
- `Mod+1-0` - Switch workspaces
- `Mod+Shift+1-0` - Move window to workspace
- `Mod+h/j/k/l` - Focus windows (vim keys)
- `Mod+Shift+c` - Reload config
- `Mod+Shift+r` - Restart i3

### zsh

The zsh configuration includes:

- Oh My Zsh integration
- Custom aliases and environment variables
- Modular configuration via `~/.zshrc.d/` directory
- Conda integration (if conda package is installed)

#### Setup Steps

1. Install zsh:
   ```bash
   sudo apt install zsh
   ```

2. Install Oh My Zsh (if not already installed):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. Install the zsh configuration:
   ```bash
   stow zsh
   ```

4. Set zsh as your default shell:
   ```bash
   chsh -s $(which zsh)
   ```

5. Restart your terminal or run:
   ```bash
   exec zsh
   ```

#### Modular Configuration

Additional zsh configuration files can be placed in `~/.zshrc.d/` and will be automatically sourced. For example, the conda package provides `~/.zshrc.d/conda.zsh`.

### conda

The conda configuration includes:

- `~/.condarc` - Conda configuration file
- `~/.zshrc.d/conda.zsh` - Conda initialization for zsh

#### Setup Steps

1. Install conda/miniforge:
   - Download from [Miniforge](https://github.com/conda-forge/miniforge) or [Anaconda](https://www.anaconda.com/)
   - Follow the installation instructions

2. Install the conda configuration:
   ```bash
   stow conda
   ```

3. **Important**: Update the conda path in `~/.zshrc.d/conda.zsh`:
   - Replace `/home/victor/miniforge3` with your actual conda installation path
   - Or run `conda init zsh` to regenerate the initialization script

4. Restart your shell or source the configuration:
   ```bash
   source ~/.zshrc
   ```

#### Conda Configuration

The `~/.condarc` file includes:
- Channel priorities (conda-forge, defaults)
- Auto-activate base: disabled
- Show channel URLs: enabled

### alacritty

The alacritty configuration includes:

- Catppuccin Mocha color scheme
- MesloLGS Nerd Font Mono
- Custom font sizes and settings

#### Setup Steps

1. Install alacritty:
   ```bash
   sudo apt install alacritty
   # Or build from source: https://github.com/alacritty/alacritty
   ```

2. Install the alacritty configuration:
   ```bash
   stow alacritty
   ```

3. Install required fonts:
   - MesloLGS Nerd Font Mono (or CaskaydiaCove Nerd Font)
   - Download from https://www.nerdfonts.com/font-downloads

4. Install color scheme (if not included):
   - The config references `~/.config/alacritty/catppuccin-mocha.toml`
   - You may need to download it from the [alacritty-themes](https://github.com/alacritty/alacritty-theme) repository

## Environment-Specific Notes

### Tower-5810 PC

- 4-monitor setup: DP-0 (left portrait), DP-5 (top), DP-6 (bottom primary), DP-2 (right portrait)
- Workspaces are assigned to specific monitors
- Polybar launches on all monitors with special handling for DP-5 (smaller bar)
- DPI fix applied for cursor size

### Laptop

- Single monitor auto-detection
- All workspaces on the primary monitor
- Standard polybar configuration
- Simplified monitor setup

### WSL

- No xrandr/monitor setup (handled by WSLg)
- No polybar (X11 display limitations)
- Minimal i3 configuration
- Workspace assignments disabled

## Maintenance

### Updating Configurations

1. Make changes to files in this repository
2. Since files are symlinked, changes take effect immediately (may require app restart)
3. For i3: Reload with `Mod+Shift+R` or `i3-msg reload`

### Adding New Packages

1. Create a new directory in the repository (e.g., `newtool/`)
2. Add configuration files maintaining the target directory structure:
   ```
   newtool/
   └── .config/
       └── newtool/
           └── config
   ```
3. Install with: `stow newtool`

### Stow Best Practices

- **Dry run**: Test before installing
  ```bash
  stow -n i3  # Shows what would be linked without doing it
  ```

- **Verbose mode**: See what stow is doing
  ```bash
  stow -v i3
  ```

- **Conflict detection**: Stow will warn about existing files
  - Backup existing files before installing
  - Use `--adopt` to adopt existing files (advanced)

### Backup Existing Configurations

Before installing, backup your existing configurations:

```bash
# Backup existing i3 config
cp -r ~/.config/i3 ~/.config/i3.backup

# Backup zsh config
cp ~/.zshrc ~/.zshrc.backup
```

## Troubleshooting

### i3 Issues

- **Environment not detected correctly**: Check `~/.config/i3/detect-env.sh` and hostname
- **Monitors not configured**: Ensure `xrandr` is installed and `~/.screenlayout/monitors-setup.sh` is executable
- **Polybar not launching**: Check logs in `/tmp/polybar-*.log`

### Stow Issues

- **Symlink conflicts**: Remove existing files/symlinks first
- **Wrong target**: Use `-t` flag to specify target directory
- **Permission errors**: Ensure you have write permissions in home directory

### zsh Issues

- **Oh My Zsh not found**: Install Oh My Zsh first
- **Conda not initializing**: Update the conda path in `~/.zshrc.d/conda.zsh`

## License

This repository contains personal configuration files. Feel free to use and modify as needed.

## Contributing

This is a personal dotfiles repository. If you find something useful, feel free to adapt it to your needs.

