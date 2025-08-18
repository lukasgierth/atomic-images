function ls --wraps='lsd --icon=never --group-dirs=first --color=auto --size=short' --description='Eza instead of ls'
	# -g = show group, -o = show permission in 0644 format
	command eza --icons=never --group-directories-first --color=auto -g -o $argv;
end
