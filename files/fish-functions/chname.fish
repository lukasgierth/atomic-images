function chname
    for x in *
        set new_name (string replace -a $argv[1] $argv[2] $x)
        mv -- "$x" "$new_name"
    end
end
