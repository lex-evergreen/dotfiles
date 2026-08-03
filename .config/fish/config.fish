# Remove the fish greeting
set fish_greeting

# If fish isn't picking up binaries in PATHs, see https://github.com/fish-shell/fish-shell/issues/6594
# See https://fishshell.com/docs/current/interactive.html#shared-bindings for the default keybinds.

# PATHs
if test (uname) = "Darwin"
    # On macos, use the traditional XDG_CONFIG_HOME and add the standard XDG base directory.
    set -qx XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME $HOME/.config
    fish_add_path --path $HOME/.local/bin
    if string match -q "*Apple*" (sysctl -n machdep.cpu.brand_string)
        # On Apple Silicon Macs, homebrew installs things in /opt/homebrew
        fish_add_path --path /opt/homebrew/bin
        fish_add_path --path /opt/homebrew/sbin
    else
        # On Intel Macs, homebrew installs things at /usr/local
        fish_add_path --path /usr/local/bin
    end
else
    # On Linux, homebrew installs things at /home/linuxbrew/.linuxbrew/bin
    fish_add_path --path /home/linuxbrew/.linuxbrew/bin
end

# Bob nvim version manager
fish_add_path --path ~/.local/share/bob/nvim-bin

# Interactive use
if status is-interactive
    # Dotfiles management
    alias dotfiles='GIT_DIR=$HOME/.dotfiles git'
    alias dotfilesnvim='GIT_DIR=$HOME/.dotfiles nvim'

    # Prevent <C-z> from sending current program to background
    stty susp undef
    # Initialize zoxide
    zoxide init fish --cmd cd | source
    # Initialize fzf
    fzf --fish | source
    # Set git branch name max length
    set -g __fish_git_prompt_shorten_branch_len 20
    # fnm
    fnm env --use-on-cd --shell fish | source
end

