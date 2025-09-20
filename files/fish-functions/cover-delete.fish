function cover-delete
    for ext in flac opus ogg mp3
        for file in *.$ext
            if test -f $file
                set tmpfile tmp_$file
                echo "Processing $file"
                command ffmpeg -i $file -map 0:a -c:a copy $tmpfile
                mv -f $tmpfile $file
            end
        end
    end
    echo DONE
end
