# dotfiles

## Overview
I'm cloning this repo as a bare git repository and using simple `dotfiles` and `dotfilesnvim` aliases (via `config.fish`) to manage dotfiles.

A "bare" git repository is one whose .git files are decoupled from its tracked files. The .git files directory is specified via `--git-dir` or the `GIT_DIR` env var and the tracked files ("workspace" or "work tree") root directory is specified via `--work-tree`, the `GIT_WORK_TREE` env var, or the `core.worktree` git config. Since a bare repo requires these on _every git command_, the location of the .git files and its tracked files can be moved around freely.

The `dotfiles` alias is just `git` with `GIT_DIR=$HOME/.dotfiles`.

Because the tracked files root directory is `$HOME` and it's likely that a lot of other stuff is in `$HOME` too, the `.gitignore` file needs to specify which files should be tracked in this repo and which shouldn't. It's easier to do an allowlist for what we want to include than a blocklist for what we don't want to include, and the `*` entry at the beginning of the `.gitignore` file lets us do that.

## Getting started
1. Clone this repo 
```sh
git clone --bare \
    --config core.bare false \
    --config core.worktree $HOME \
    --config 'remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*' \
    --config branch.main.remote=origin \
    --config branch.main.merge=refs/heads/main \
    <url> $HOME/.dotfiles
```
2. Checkout the default branch 
```sh
GIT_DIR=$HOME/.dotfiles git checkout
```
You may have to delete files if there are any preexisting ones that would be overwritten.
3. Add any machine-specific fish config to `.fish` files in `~/.config/fish/conf.d/`, which will not be committed.
