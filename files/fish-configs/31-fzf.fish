# only when in interactive shell and the command exists
if status --is-interactive
    and type -q fzf
    fzf --fish | source
end
