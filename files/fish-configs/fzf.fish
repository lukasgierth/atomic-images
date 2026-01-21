# only when in interactive shell
if status --is-interactive
    if type -q zoxide
        fzf --fish | source
    end
end
