# only needed in interactive shell
if [[ $- == *i* ]]; then
	dnf() {
		echo "Layering disabled, but if you really need to use dnf:"
		echo "/usr/bin/dnf"
		return 1
	}
	dnf5() {
		echo "Layering disabled, but if you really need to use dnf5:"
		echo "/usr/bin/dnf5"
		return 1
	}
fi
