function mise-install-global --wraps="mise install"
    # install tool and use globally for user
    command mise install $argv
    command mise use -g $argv
end
