.rc
===

A meta repository for all config files.  Currently the following configs are included, in different repositories.

* [dircolors](../../../.rc.dircolors/)
* [gitconfig](../../../.rc.gitconfig/)
* [tig](../../../.rc.tig)
* [tmux](../../../.rc.tmux)
* [vim](../../../.rc.vim)
* [zsh](../../../.rc.zsh)

The name of these repositories are `.rc.<COFIG_NAME>`, which is also a github
repository.  For example, the config files of dircolors are in `cwahbong/.rc.dircolors`.

Download/Update
---------------

The command downloads and updates all config files.

    make update

It is done by git clone and calling make update in each config repository
(mostly done by git pull).

Note that it will choose the same protocol as that of this repository to clone.

Install
-------

The command installs all config files.

    make install
