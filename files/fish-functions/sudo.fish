function sudo --wraps="sudo"
    command sudo --preserve-env=PATH env $argv
end
