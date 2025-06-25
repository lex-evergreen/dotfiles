# Remove the fish greeting
set fish_greeting

# If fish isn't picking up binaries in PATHs, see https://github.com/fish-shell/fish-shell/issues/6594
# See https://fishshell.com/docs/current/interactive.html#shared-bindings for the default keybinds.

# PATHs
if test (uname) = "Darwin"
    # On macos, use the traditional XDG_CONFIG_HOME.
    set -qx XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME $HOME/.config
    if string match -q "*Apple*" (sysctl -n machdep.cpu.brand_string)
        # On Apple Silicon Macs, homebrew installs things in /opt/homebrew
        contains /opt/homebrew/bin
        or set PATH /opt/homebrew/bin $PATH
    else
        # On Intel Macs, homebrew installs things at /usr/local
        contains /usr/local/bin
        or set PATH /usr/local/bin $PATH
    end
else
    # On Linux, homebrew installs things at /home/linuxbrew/.linuxbrew
    contains /home/linuxbrew/.linuxbrew
    or set PATH /home/linuxbrew/.linuxbrew $PATH
end

contains ~/.local/share/bob/nvim-bin
or set PATH ~/.local/share/bob/nvim-bin $PATH

# Interactive use
if status is-interactive
    # Dotfiles management
    alias dotfiles='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git'
    alias dotfilesnvim='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim'

    # Prevent <C-z> from sending current program to background
    stty susp undef
    # Initialize zoxide
    zoxide init fish --cmd cd | source
    # Initialize fzf
    fzf --fish | source
    # Set git branch name max length
    set -g __fish_git_prompt_shorten_branch_len 20
end

