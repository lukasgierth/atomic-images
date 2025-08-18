function virsh --wraps='virsh'
    command virsh --connect qemu:///system $argv
end
