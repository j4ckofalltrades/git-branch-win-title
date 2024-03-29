![git-branch-win-title](https://res.cloudinary.com/j4ckofalltrades/image/upload/v1697278939/foss/gh-social-icons/git-branch-win-title_bkf47c.png)

A small shell function that adds the current git branch (if present) to the terminal emulator window title.

## Requirements

- [Git](https://git-scm.com) v2.2 or higher 
- Any [supported terminal emulator](#terminal-emulator-support)
- Any [supported shell interpreter](#shell-interpreter-support)

## Quick Start

Configuration may vary depending on the user's OS, terminal emulator, and shell
interpreter. But in most cases, the following command should be enough:

```sh
$ source branch-win-title.sh
```

You may also want to add this line to your shell configuration file e.g.
`.profile`, `.bashrc`, `.zshrc`, etc.

## Shell interpreter support

- [bash](https://www.gnu.org/software/bash)
- [zsh](https://github.com/zsh-users/zsh)

## Terminal Emulator support

Tested on the following terminal emulators:

- [Alacritty](https://github.com/alacritty/alacritty)
- [iTerm2](https://github.com/gnachman/iTerm2)
- [Gnome Terminal](https://github.com/GNOME/gnome-terminal)
- [Guake](https://github.com/Guake/guake)

## Additional configuration

### Powerline

The `branch-win-title.sh` script must be loaded first before configuring
powerline otherwise it will override the powerline-generated shell prompt.

### Guake

Enable the following settings under `Main Window`:

- Show tab bar
- Use VTE titles for tab names

### iTerm2

Enable the following settings under `Preferences > Profiles`:

- Terminal may set tab/window title

### Tmux

Add the following entries to `.tmux.conf`:

```bash
set-option -g set-titles on
set-option -g set-titles-string "#T"
set-option -g automatic-rename on
```

## Demo

![](branch-win-title.gif)
