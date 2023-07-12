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

if command -v nvim >/dev/null
then
    export EDITOR=nvim
    export VISUAL=nvim
    alias vimdiff='nvim -d'
else
    if command -v vim >/dev/null
    then
        export EDITOR=vim
        export VISUAL=vim
    else
        export EDITOR=vi
        export VISUAL=vi
    fi
fi

vim() {
    command $EDITOR $@
}

if [[ ${EUID} == 0 ]]
then
        export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
        export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi

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

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | awk '{print $NF}')"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

jq() {
    command python -m json.tool $@
}
