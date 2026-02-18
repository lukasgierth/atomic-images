# only when in interactive shell and the command exists
if status --is-interactive
    and type -q notify-send
    # Send notification when command takes longer than 5m to finish, set CMD_DURATION to change time
    function notify_long_commands --on-event fish_postexec
        if test -n "$CMD_DURATION" -a $CMD_DURATION -ge 300000
            set -l duration_s (math -s0 "$CMD_DURATION / 1000")
            set -l command_text (string join " " $argv | string sub --length 50)
            test (string length (string join " " $argv)) -gt 50; and set command_text "$command_text..."
            notify-send -u low -i utilities-terminal "Command Finished ($duration_s s)" "$command_text"
        end
    end
end
