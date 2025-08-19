function folders-compare
    command rsync -avun --delete $argv[1] $argv[2] | grep '^deleting '
    command rsync -avun --delete $argv[2] $argv[1] | grep '^deleting '
end
