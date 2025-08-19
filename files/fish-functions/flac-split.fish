function flac-split
    command shntool split -f $argv[1] -o flac *.flac
end
