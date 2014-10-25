#!/usr/bin/env sh

RC_PREFIX=${HOME}"/.rc/"
LOG=${RC_PREFIX}"config.log"

GIT="git"
REPO_PREFIX="https://github.com/cwahbong/."

REPOS="vim tmux"

git_clone () {
	${GIT} clone ${REPO_PREFIX}${1} ${RC_PREFIX}${1} 2>> $LOG
	ret=$?
	if [ $ret -ne 0 ]; then
		echo "Failed while git cloning ${1} config."
	fi
	return $ret
}

repo_config_install () {
	${RC_PREFIX}${1}/config.sh install 2>> $LOG
	ret=$?
	if [ $ret -ne 0 ]; then
		echo "There is something wrong while installing ${1} config."
	fi
	return $ret
}

CONFIG_CLONE () {
	for repo in $REPOS; do
		git_clone $repo
	done
	return 0
}

CONFIG_INSTALL () {
	CONFIG_CLONE
	for repo in $REPOS; do
		repo_config_install $repo
	done
	return 0
}

CONFIG_HELP () {
	echo 'Usage: config.sh {clone|install|uninstall}'
	return $(($? || $#))
}

OP=${1}
shift
case ${OP} in
	"clone")
		CONFIG_CLONE $@
		;;
	"install")
		CONFIG_INSTALL $@
		;;
	"help")
		CONFIG_HELP $@
		;;
	*)
		CONFIG_HELP $@
		exit $(($? || 1))
		;;
esac
exit $?

