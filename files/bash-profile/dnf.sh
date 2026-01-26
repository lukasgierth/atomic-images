# only needed in interactive shell
if [[ $- == *i* ]]; then
	dnf() {
		echo "Layering disabled, but if you really need to use dnf:"
		echo "/usr/bin/dnf"
		exit 1
	}
	dnf5() {
		echo "Layering disabled, but if you really need to use dnf5:"
		echo "/usr/bin/dnf5"
		exit 1
	}
	microdnf() {
		echo "Layering disabled, but if you really need to use microdnf:"
		echo "/usr/bin/microdnf"
		exit 1
	}
	yum() {
		echo "Layering disabled, but if you really need to use yum:"
		echo "/usr/bin/yum"
		exit 1
	}
fi
