function dl-yt --wraps="yt-dlp"
    pushd ~/Videos
    command yt-dlp -f "bv*[height<=1080]+ba*[acodec=opus]" --remux-video mkv --external-downloader=aria2c --external-downloader-args '--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16' $argv
    popd
end
