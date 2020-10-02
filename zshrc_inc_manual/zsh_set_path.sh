#!/usr/bin/env false zsh
# -*- coding: utf-8 -*-
    # shellcheck shell=bash
    # shellcheck source=/dev/null
    # shellcheck disable=2178,2128,2206,2034
#? ################# .functions - functions for macOS with zsh ###############
	#* copyright (c) 2019 Michael Treanor     -----     MIT License
	#* should not be run directly; called from .bash_profile / .bashrc / .zshrc
#? ######################## https://www.github.com/skeptycal #################
	# SET_DEBUG=${SET_DEBUG:-0} # set to 1 for verbose testing

#? ###################### copyright (c) 2019 Michael Treanor #################

# ?########################################## parameter expansion tips
	#? ${PATH//:/\\n}    - replace all colons with newlines
	#? ${PATH// /}       - strip all spaces
	#? ${VAR##*/}        - return only final element in path (program name)
	#? ${VAR%/*}         - return only path (without program name)

#? ######################## PATH
    # expand path with newlines
    alias path="echo ${PATH//:/'\n'}"

    # list path elements with color coded (green is ok, orange is broken)
    checkpath() {
        IFS=':'
        for p in $PATH; do
            [ -d $p ] && lime $p || attn $p
        done
        }

    declare -x PATH="\
        /usr/local/Cellar/gnupg/2.2.23/bin:\
        /usr/local/opt/coreutils/libexec/gnubin:\
        $HOME/bin:\
        /usr/local/bin:\
        /usr/local/opt:\
        $HOME/.dotfiles/.oh-my-zsh:\
        $HOME/.poetry/bin:\
        $HOME/Library/Python/3.8/bin:\
        /usr/local/lib/node_modules/bin:\
        /usr/local/Cellar/ruby/2.7.1_2/bin:\
        /usr/local/opt/cython/bin:\
        /bin:\
        /usr/local:\
        /usr/local/sbin:\
        /usr/bin:\
        /usr/sbin:\
        /sbin:\
        /usr/libexec:\
        /usr/local/opt/sphinx-doc/bin:\
        $HOME/.dotfiles:\
        $HOME/.dotfiles/git-achievements:"
        # '$PWD'

    PATH="${PATH// /}" # remove spaces

    # vscode is kinda odd sometimes ... sometimes with spaces, sometimes not ???
    #   so ... I'm putting the 'space remover' before it ...
    # PATH="$PATH:/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin:"
    PATH=$PATH'/Applications/Visual Studio Code.app/Contents/Resources/app/bin:'

    PATH="${PATH//::/:}" # remove double colons ... you know you've done it, too

    export PATH

#? ######################## MANPATH
    # /usr/local/opt/erlang/lib/erlang/man:\

    declare -x MANPATH=" \
        /usr/local/man:\
        /usr/local/opt/coreutils/libexec/gnuman:\
        /usr/share/man:\
        /usr/local/share/man:\
        /Library/Frameworks/Python.framework/Versions/Current/share/man/man1:\
        /usr/local/texlive/2020/texmf-dist/doc/man:\
        "
    MANPATH="${MANPATH// /}"

    export INFOPATH="/usr/local/texlive/2020/texmf-dist/doc/info:$INFOPATH"
