bashsig () {
	printf 'eval '
	local GETOPTARG
	local -a GETOPTARGS
	local ARG
	while [[ $# -gt 0 && ( $1 == -* || $1 == : ) ]]; do
		ARG=${1#-}
		GETOPTARG+=$ARG
		ARG=${ARG%:}
		GETOPTARGS+=("$ARG")
		shift
	done
	if [[ $GETOPTARGS ]]; then
		printf 'local OPT OPTARG OPTIND; '
		printf 'while getopts %s OPT; do ' "${GETOPTARG@Q}"
		printf 'case "$OPT" in '
		for ARG in "${GETOPTARGS[@]}"; do
			printf '%s) local %s=${OPTARG:-TRUE} ;; ' "$ARG" "$ARG"
		done
			printf '?|:) return 1 ;; ' "$ARG" "$ARG"
		printf 'esac; done; shift $((OPTIND-1)); '
	fi
	while [[ $# -gt 0 && $1 != @ ]]; do
		printf 'local %s=$1; shift; ' "$1"
		shift
	done
	if [[ $# -eq 1 ]]; then
		:
	elif [[ $# -eq 0 ]]; then
		printf '[[ $# -eq 0 ]] || { echo "Too many/few arguments passed to function"; return 1; }; '
	else
		echo '@ appeared before it was the last argument'
		exit 1
	fi
	printf '\n'
}
