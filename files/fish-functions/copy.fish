function copy
    set -l ignore_existing 0
    if test $argv[1] = -u
        set ignore_existing 1
        set argv $argv[2..-1]
    end

    # The last argument is the destination
    set -l dest $argv[-1]
    # All but the last arguments are sources
    set -l sources $argv[1..-2]

    for src in $sources
        if test $ignore_existing -eq 1
            command rsync -Phrva --ignore-existing "$src" "$dest"
        else
            command rsync -Phrva "$src" "$dest"
        end
    end

    command sync
end
