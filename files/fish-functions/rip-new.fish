function rip-new
    pushd ~/Rip
    command whipper drive analyze
    command whipper offset find
    command whipper cd rip --compression-level 8
    popd
end
