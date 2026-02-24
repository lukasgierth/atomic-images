function pangolin-cli --wraps='pangolin-cli'
    if test "$argv[1]" = update
        echo "Updating binary disabled by image maintainer, pangolin-cli is updated with image itself"
        return 1
    else
        command pangolin-cli $argv
    end
end
