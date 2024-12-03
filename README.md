# Lex's dotfiles

## Overview

### Git repo
I'm cloning this repo as a bare git repository and using a simple `dotfiles` alias (via `config.fish`) to manage dotfiles.
A "bare" git repository is one whose .git files are decoupled from its tracked files. The .git files directory is specified via `--git-dir` and the tracked files ("workspace" or "work tree") root directory is specified via `--work-tree`. Since these are specified on _every git command_, you can move these around as needed.
The `dotfiles` alias is just `git` with `--git-dir=$HOME/.dotfiles/` and `--work-tree=$HOME`.
Because the tracked files root directory is `$HOME` and it's likely that a lot of other stuff is in `$HOME` too, the `.gitignore` file needs to specify which files should be tracked in this repo and which shouldn't. It's easier to do an allowlist for what we want to include than a blocklist for what we don't want to include, and the `*` entry at the beginning of the `.gitignore` file lets us do that.

## Initial setup

### Getting started
1. Pick a `~` directory (if you're using Distrobox it's probably best to choose a different directory than your host's `~`).
2. Clone this repo `--bare` into `~/.dotfiles`.
3. Run `alias dotfiles='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git'` - this will not persist, but will be replaced by the alias in `config.fish`.
4. Run `dotfiles checkout` - you may have to delete files if there are any preexisting ones that would be overwritten.
5. Run `dotfiles config --local core.worktree $HOME` to get `dotfilesnvim` fugitive working.

### Container setup
Distrobox only mounts your host's `~` (home), but your container's `~` can be somewhere else so that dotfiles can be different and not cross-contaminate.

#### Create Distrobox container
Clone this repo to `~/distrobox-homes/dev-fedora`
Run the following commands inside that directory
```sh
distrobox assemble create --file dev-fedora.ini
distrobox enter dev-fedora
```

#### Install packages
Here are some useful sets:
_Development_
```sh
sudo dnf install neovim git-credential-oauth zoxide fzf luarocks dotnet-sdk-8.0 rustup pnpm npm
```
_Tauri_
The following can be found [here](https://v2.tauri.app/start/prerequisites):
```sh
sudo dnf install webkit2gtk4.1-devel openssl-devel curl wget file libappindicator-gtk3-devel librsvg2-devel
sudo dnf group install "c-development"
```

I've tried adding these to the `additional_packages` section of `dev-fedora.ini`, but for some reason they create some folders as owned by the `root` of the container (not the root of the host), and this causes permissions issues. For example, installing `neovim` this way currently creates the `.local` folder as owned by `root` instead of the user. This is why packages are installed manually in these instructions.

#### Perform some initial setup
If your login shell isn't `fish`, change that now
```sh
chsh -s /usr/bin/fish
```
Initialize `git-credential-oauth` and set a default user.
```sh
git credential-oauth configure
git config --global user.email [email]
git config --global user.name [name]
```
If your global user isn't the user you want to use for committing to dotfiles, you can use this command to set which user to use
```sh
dotfiles config credential.https://github.com/lex-evergreen/dotfiles.git.username [username]
```
TODO: maybe this config could be stored in dotfiles?

### Entering the container automatically
If you're using a terminal emulator that can run a custom command at start, you can set it to the following to automatically enter the container when you open the terminal.
```
distrobox enter dev-fedora
```

