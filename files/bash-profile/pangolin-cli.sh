pangolin-cli() {
	if [ "$1" = "update" ]; then
		echo "Updating binary disabled by image maintainer, pangolin-cli is updated with image itself"
		return 1
	else
		command pangolin-cli "$@"
	fi
}
