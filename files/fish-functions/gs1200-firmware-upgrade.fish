function gs1200-firmware-upgrade
    if test (count $argv) -lt 1
        echo "Usage: GS1200_firmware_upgrade IP"
        return 1
    end

    set U_IP $argv[1]
    rm GS1200-*.bin ^/dev/null
    unzip -u GS1200-*.zip

    set U_FIRM (ls GS1200-*.bin)
    curl -F "firmware=<$U_FIRM" -o /dev/null "http://$U_IP/httpupg.cgi?cmd=fw_upgrade"
end
