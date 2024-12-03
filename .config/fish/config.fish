# Remove the fish greeting
set fish_greeting

# If fish isn't picking up binaries in PATHs, make sure to add "-l" to the beginning
# of the fish command (usually in terminal config) to start it in interactive mode.

# PATHs
if test (uname) = "Darwin"
    # Fix Alt+F keybinding on MacOS. It's supposed to accept just the next autosuggested word.
    # See https://github.com/fish-shell/fish-shell/blob/master/doc_src/cmds/bind.rst
    bind \e\[102\;9u forward-bigword

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

# Interactive use
if status is-interactive
    # Dotfiles management
    alias dotfiles='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git'
    alias dotfilesnvim='GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME nvim'

    # Initialize zoxide
    # zoxide fish autocomplete doesn't really work right now. See https://github.com/ajeetdsouza/zoxide/issues/811
    # You can get suggestions by adding a space after your guess and pressing tab.
    zoxide init fish --cmd cd | source
    # Tried the following config as a result of a comment on that issue, doesn't seem to work.
    # complete -e cd
    # complete -c cd -a '(__fish_complete_cd)'

    # Initialize fzf
    fzf --fish | source
end
