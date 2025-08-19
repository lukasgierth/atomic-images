function flash-keyboard
    # Define valid options as a list
    set options binepad-bn006 binepad-bn009 bm60hsrgb-poker duckypad freebirdnplite tiger18

    if test (count $argv) -eq 0
        echo "Usage: flash-keyboard <option>"
        echo "Allowed options:"
        for opt in $options
            echo "  $opt"
        end
        return 1
    end

    switch $argv[1]
        case binepad-bn006
            echo "Starting flashing..."
            sudo dfu-util --device ,1eaf:0003 -a 2 -R -D $argv[2]
            return 0

        case binepad-bn009
            echo "Starting flashing..."
            sudo dfu-util --device ,1eaf:0003 -a 2 -R -D $argv[2]
            return 0

        case bm60hsrgb-poker
            echo "Starting flashing..."
            sudo dfu-programmer atmega32u4 erase --force
            sudo dfu-programmer atmega32u4 flash $argv[2]
            sudo dfu-programmer atmega32u4 reset
            return 0

        case duckypad
            echo "Starting flashing..."
            sudo dfu-util --device ,0483:df11 -a 0 -D $argv[2]
            return 0

        case freebirdnplite
            echo "Starting flashing..."
            sudo dfu-programmer atmega32u2 erase --force
            sudo dfu-programmer atmega32u2 flash $argv[2]
            sudo dfu-programmer atmega32u2 reset
            return 0

        case tiger80
            echo "Starting flashing..."
            sudo dfu-programmer atmega32u4 erase --force
            sudo dfu-programmer atmega32u4 flash $argv[2]
            sudo dfu-programmer atmega32u4 reset
            return 0

        case '*'
            echo "Unknown option: $argv[1]"
            echo "Run without arguments to see usage."
            return 1
    end
end
