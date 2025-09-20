function flac-to-opus
    for i in *.flac
        if test -f $i
            set output (string replace -r '\.flac$' '.opus' -- $i)
            command ffmpeg -i $i -c:a libopus -b:a 128000 -compression_level 10 -ac 2 $output
        end
    end
    command sync
    rm -f *.flac
end
