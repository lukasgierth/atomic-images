function cover-convert --wraps="magick"
    magick $argv[1] -colorspace YUV -resize $argv[2]x$argv[2] -sampling-factor 4:2:0 neu.jpg
end
