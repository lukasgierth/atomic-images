function proxy --wraps="ssh"
    command ssh -N -D 9090 $argv
end
