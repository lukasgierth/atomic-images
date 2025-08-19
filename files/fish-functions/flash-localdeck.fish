function flash-localdeck --wraps="esptool"
    sudo esptool --chip esp32-c3 -p /dev/ttyACM0 write_flash 0x0 $argv[1]
end
