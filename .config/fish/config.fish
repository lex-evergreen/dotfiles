# Remove the fish greeting
set fish_greeting

# Commands to run in interactive sessions can go here
if status is-interactive
zoxide init fish --cmd cd | source
fzf --fish | source
end
