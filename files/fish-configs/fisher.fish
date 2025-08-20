# change fisher paths to local/share
set -g fisher_path ~/.local/share/fish/fisher
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

# source all files/plugins
for file in $fisher_path/conf.d/*.fish
    source $file
end
