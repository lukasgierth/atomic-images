# only when in interactive shell and the command exists
if status --is-interactive
    function dnf
        echo "Layering disabled, but if you really need to use dnf:"
        echo /usr/bin/dnf
        exit 1
    end
    function dnf5
        echo "Layering disabled, but if you really need to use dnf5:"
        echo /usr/bin/dnf5
        exit 1
    end
end
