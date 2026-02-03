# only when in interactive shell
if status --is-interactive
    # FIX: revert back when atuin version in fedora is newer again and this has been fixed upstream
    atuin init fish | tac | sed '1,5s/ -k//' | tac | source
    # atuin init fish | source
end
