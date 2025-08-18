function tree --wraps='eza --icons=never --group-directories-first --color=autio --tree' --description 'Use eza as tree'
	command eza --icons=never --group-directories-first --color=auto --tree $argv;
end
