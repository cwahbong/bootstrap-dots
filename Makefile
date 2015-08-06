GIT_REMOTE_ORIGIN_URL = $(shell git config --get remote.origin.url)
GITREPO_PREFIX = $(patsubst %.git, %., $(GIT_REMOTE_ORIGIN_URL))

COMMANDS = all update install clean
SUBDIRS = \
	dircolors\
	vim\
	gitconfig\
	tig\
	tmux\
	zsh

$(COMMANDS): $(SUBDIRS)
	@for SUBDIR in $(SUBDIRS); do\
		$(MAKE) -C $$SUBDIR $@ || exit;\
	done

$(SUBDIRS):
	git clone $(GITREPO_PREFIX)$@ $@

Makefile: ; # Do not remake makefile.

.PHONY: $(COMMANDS)
