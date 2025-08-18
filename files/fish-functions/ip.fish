function ip --wraps='ip --color=always' --description='ip with colors enabled'
	command ip --color=always $argv;
end
