# Remove the fish greeting
set fish_greeting

# Commands to run in interactive sessions can go here
if status is-interactive
    # Initialize zoxide
    zoxide init fish --cmd cd | source
    # Initialize fzf
    fzf --fish | source
    # Add the dotfiles alias
    alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
end
