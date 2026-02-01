function cyanrip --wraps="cyanrip"
    pushd ~/Rips
    command cyanrip -s 6 -o flac -U -G -Q $argv
    popd
end
