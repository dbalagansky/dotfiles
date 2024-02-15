export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

shopt -s histappend
shopt -s checkwinsize

stty -ixon

export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=100000
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

if command -v vim >/dev/null
then
    export EDITOR=vim
    export VISUAL=vim
else
    export EDITOR=vi
    export VISUAL=vi
fi

vim() {
    command $EDITOR $@
}

if [ -d "$HOME/.pyenv" ]
then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"

    if command -v pyenv 1>/dev/null 2>&1
    then
        eval "$(pyenv init -)"
    fi
fi

if command -v kubectl 1>/dev/null 2>&1
then
    source <(kubectl completion bash)
fi

python() {
    if [ "$#" -eq 0 ]; then
        PYTHONSTARTUP=~/.pythonrc $(type -P python)
    else
        $(type -P python) "$@"
    fi
}

workon() {
    if [ -d "$HOME/.virtualenvs/${1:-venv}" ]
    then
        source "$HOME/.virtualenvs/${1:-venv}/bin/activate"
    elif [ -d "${1:-venv}" ]
    then
        source "${1:-venv}/bin/activate"
    else
        return 1
    fi
}

mkvirtualenv() {
    python3 -m venv "${1:-venv}" && source "${1:-venv}/bin/activate"
}
alias mkvenv='mkvirtualenv'

jq() {
    command python -m json.tool $@
}
