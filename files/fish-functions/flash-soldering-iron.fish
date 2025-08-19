function flash-soldering-iron
    # Define valid options as a list
    set options pinecil-v1 pinecil-v2 ts100

    if test (count $argv) -eq 0
        echo "Usage: flash-soldering-iron <option>"
        echo "Allowed options:"
        for opt in $options
            echo "  $opt"
        end
        return 1
    end

    switch $argv[1]
        case pinecil-v1
            echo "INFO: Get into flashing mode by pressing - before connecting USB, keep pressed for 15 more seconds"
            echo "Starting flashing..."
            if string match -qr '\.dfu$' -- $argv[2]
                sudo dfu-util -D $argv[2]
                return 0
            else
                echo "Error, only .dfu files allowed!"
                return 1
            end

        case pinecil-v1
            echo "INFO: Get into flashing mode by pressing - before connecting USB, keep pressed for 15 more seconds"
            echo "Starting flashing..."
            if string match -qr '\.bin$' -- $argv[2]
                sudo blisp write -c bl70x --reset $argv[2]
                return 0
            else
                echo "Error, only .bin files allowed!"
                return 1
            end

        case ts100
            echo "Starting flashing..."
            set FW $argv[2]
            set NAME (command lsblk -P -p -d -o NAME,MODEL | grep "DFU[ _]Disk" | awk -F'"' '{print $2}')

            if test -z "$NAME"
                echo "Error, DFU disk not found!"
                return 1
            end

            sudo umount $NAME
            sudo mkdir -p /tmp/mntdfu
            sudo mount -t msdos $NAME /tmp/dfu

            set BASENAME (basename $FW | string upper)
            sudo cp $FW /tmp/dfu/$BASENAME; and sync

            sudo umount /tmp/dfu
            sudo rmdir /tmp/mntdfu
            return 0

        case '*'
            echo "Unknown option: $argv[1]"
            echo "Run without arguments to see usage."
            return 1
    end
end
