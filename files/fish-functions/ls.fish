function ls --wraps='eza --icons=never --group-directories-first --color=auto -g -o' --description='Eza instead of ls'
	# -g = show group, -o = show permission in 0644 format
	command eza --icons=never --group-directories-first --color=auto -g -o $argv;
end
