# only needed in interactive shell
if [[ $- == *i* ]]; then
	dnf() {
		echo "Layering disabled, but if you really need to use dnf:"
		echo "/usr/bin/dnf"
	}
	dnf5() {
		echo "Layering disabled, but if you really need to use dnf5:"
		echo "/usr/bin/dnf5"
	}
	microdnf() {
		echo "Layering disabled, but if you really need to use microdnf:"
		echo "/usr/bin/microdnf"
	}
	yum() {
		echo "Layering disabled, but if you really need to use yum:"
		echo "/usr/bin/yum"
	}
fi
