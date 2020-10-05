#!/usr/bin/env zsh
# -*- coding: utf-8 -*-
    # shellcheck shell=bash
    # shellcheck source=/dev/null
    # shellcheck disable=2178,2128,2206,2034
#? ################# .functions - functions for macOS with zsh ###############
	#* copyright (c) 2019 Michael Treanor     -----     MIT License
	#* should not be run directly; called from .bash_profile / .bashrc / .zshrc
#? ######################## https://www.github.com/skeptycal #################
	SET_DEBUG=${SET_DEBUG:-0} # set to 1 for verbose testing
	SCRIPT_NAME=${0##*/}
	_debug_tests() {
		if (( SET_DEBUG == 1 )); then
			printf '%b\n' "${WARN:-}Debug Mode Details for ${CANARY}${SCRIPT_NAME##*/}${RESET:-}"
			green "DEFAULT_ENVIRONMENT_FOLDER_NAME: $DEFAULT_ENVIRONMENT_FOLDER_NAME"
		fi
	}
#? ###################### copyright (c) 2019 Michael Treanor #################

#? ######################## Python
	#   set hash seed to different random number every session
	unset PYTHONDONTWRITEBYTECODE
	export PYTHONHASHSEED="$(shuf -i1-4294967295 -n1)"
	export PYTHONIOENCODING='UTF-8'

# *############################################## repo setup
    alias please='sudo '
    alias gig='cp $HOME/.dotfiles/.gitignore .'

    alias d="docker "

    alias pc='pre-commit '
    alias pci='pre-commit install && pre-commit install-hooks && pre-commit autoupdate'
    alias pca='pre-commit run --all-files'

# *############################################## pip
	# As of pip 20.2.2
	# 	this is a new option to resolve dependencies
	# 	--use-feature=2020-resolver
	# alias pip='pip --use-feature=2020-resolver || pip ' # causes errors
	# alias piu='pip install -U --use-feature=2020-resolver '

	# 'piplist' is not part of the normal python installation. It returns a
	# list of names of installed packages suitable for process and piping,
	# without the header and extra fields. The function recreates the list on
	# demand so it is always current.
	piplist() { pip3 list | sed 's/  */ /g' | cut -d ' ' -f 1 | tail -n +3; }

	# This constant version is precalculated once at boot time and will always
	# contain the global pip list from shell start time.
	PIPLIST="$(pip3 list | sed 's/  */ /g' | cut -d ' ' -f 1 | tail -n +3; )"


	# TODO - conflicts with venv ... python environments alway suck
    pip4() { pip3 --use-feature=2020-resolver "$@"; }
    piu() { pip3 install -U --use-feature=2020-resolver "$@"; }
    alias pipup="piplist | xargs pip3 install -U ;"

# *############################################## python related
	alias py="python3 -m "

	# change all .py files in current folder to executable
	alias modpy='chmod +x *.py -c --preserve-root -- '

	# display current python path
	alias pypath='python3 -c "import sys; print(sys.path)" | tr "," "\n" | grep -v "egg"'

	# clean out stale pycache files
	alias pycclean='find $PWD -name "*.pyc" -exec rm -rf {} \; && find $PWD -name "__pycache__" -exec rm -rf {} \;'

    alias pret='prettier * --write --insert-pragma'
	alias quickpret='prettier -uw * 2>/dev/null'
    alias pm="pygmentize"

	alias dj="python3 manage.py runserver"
	alias servethis="python -c 'import SimpleHTTPServer; SimpleHTTPServer.test()'"

#? ######################## pyenv setup
    [[ $(command -v pyenv >/dev/null) ]] && eval "$(pyenv init -)"
    [[ $(command -v pyenv-virtualenv-init >/dev/null) ]] && eval "$(pyenv virtualenv-init -)"

# *############################################## python virtual environment
    # DEFAULT_ENVIRONMENT_FOLDER_NAME='.venv'
    # older path was 'venv'

	# create a venv
	alias pyv='python -m venv .venv'
	# the ubiquitous "source bin activate"s ...
	alias sba='. .venv/bin/activate'
	# turn off the venv
	alias sda='deactivate'

	# ! these hide configuration errors where aliases are ignored in poetry
	# alias python='python3 '
	# alias pip='pip3 '

# *############################################## poetry
    #   python environments suck ... a lot ... virtual environments suck ...
    #   someone should find a better way to do this ... it's so stupid

    #   poetry is the best alternative for now, but there seems to be one
    #   issue that completely ruins poetry: it corrupts pip

    #   if pip becomes corrupted, I have a utility called 'repip' that
    #   fixes it. 'repip' will reinstall pip, check versions of all repos,
    #   install updates, and check dependencies with the new (as of 7/2020)
    #   feature to check version compatibility: --use-feature=2020-resolver

    	# poetry init [--name <...>] [--description <...>] [--author <...>] [--dependency <...>] [--dev-dependency <...>] [-l <...>]

	alias p="poetry "
	alias pu="poetry update"
	alias pb="poetry build"
	alias pub="poetry publish --build"

	alias pi='poetry init'
	alias pos='poetry show'
	alias pst="poetry show --tree"
	alias prr='poetry export -f requirements.txt >requirements.txt'

	#   python sucks ... virtual environments suck ...
	#   someone should find a better way to do this ... it's so stupid
	#   'poetry' is the best alternative for now
	export POETRY_REPOSITORIES_TESTPYPI_URL="https://test.pypi.org/legacy/"
	export POETRY_PYPI_TOKEN_TESTPYPI='<token>'

	export POETRY_CACHE_DIR="$HOME/Library/Caches/pypoetry"
	export POETRY_VIRTUALENVS_PATH="${POETRY_CACHE_DIR}/virtualenvs"
	export POETRY_PYPI_TOKEN_PYPI=my-token

# *############################################## pipenv
	# * I use Poetry instead of PipEnv for now
	# alias pe='pipenv'
	# alias pes='pipenv shell'
	# alias pei='pipenv install'
	# alias peg='pipenv graph'
	# alias ve="virtualenv"
	# alias vew="virtualenvwrapper"

_debug_tests
true