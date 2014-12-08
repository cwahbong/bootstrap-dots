#!/usr/bin/env sh
set -u

MESSAGE='printf "%8s %s\n"'

INFO='\033[0;37m[INFO]\033[0;m'
WARN='\033[0;33m[WARN]\033[0;m'
ERROR='\033[0;31m[ERROR]\033[0;m'

RC_PREFIX="${HOME}/.rc"
LOG="${RC_PREFIX}/config.log"

REPO_PREFIX='https://github.com/cwahbong'

REPOS='vim tmux'

message() {
	printf "%-20b %s\n" "$@"
}

git_clone () {
	if [ -d "${RC_PREFIX}/${1}" ]; then
		message "$WARN" "Directory exists, skip cloning ${1} config."
		return 0
	fi

	message "$INFO" "Cloning ${1} config..."
	if ! git clone "${REPO_PREFIX}/.rc.${1}" "${RC_PREFIX}/${1}" 2>> "$LOG"; then
		message "$ERROR" "Failed while git cloning ${1} config."
		return 1
	fi
}

repo_config_install () {
	CONFIG_PREFIX="${RC_PREFIX}/${1}"

	message "$INFO" "Installing ${1} config..."
	if ! "${CONFIG_PREFIX}/config.sh" install "${CONFIG_PREFIX}" ; then
		message "$ERROR" "There is something wrong while installing ${1} config."
		return 1
	fi
}

CONFIG_CLONE () {
	for repo in $REPOS; do
		git_clone "$repo"
	done
}

CONFIG_INSTALL () {
	CONFIG_CLONE
	for repo in $REPOS; do
		repo_config_install "$repo"
	done
}

CONFIG_HELP () {
	echo 'Usage: config.sh {clone|install|uninstall}'
}

OP=${1}
shift
case ${OP} in
	clone)
		CONFIG_CLONE "$@"
		;;
	install)
		CONFIG_INSTALL "$@"
		;;
	help)
		CONFIG_HELP "$@"
		;;
	*)
		CONFIG_HELP "$@"
		exit 1
		;;
esac
