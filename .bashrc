export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=${PATH}:/Applications/VirtualBox.app/Contents/MacOS/

shopt -s histappend
shopt -s checkwinsize

stty -ixon

export HISTCONTROL=ignoredups:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTSIZE=10000
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

if command -v nvim >/dev/null;
then
    export EDITOR=nvim
    export VISUAL=nvim
    alias vimdiff='nvim -d'
else
    export EDITOR=vim
    export VISUAL=vim
fi

if [ `id -u` -eq 0 ]
then
        export PS1='[\u@\h \W]\# '
        #export PS1='\h: \033[34m\w\033[0m \033[1;31m#\033[0m '
else
        export PS1='[\u@\h \W]\$ '
        #export PS1='\h: \033[34m\w\033[0m \033[1;32m$\033[0m '
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export VIRTUALENVWRAPPER_PYTHON=`pyenv which python`
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
if command -v pyenv 1>/dev/null 2>&1; then
    pyenv virtualenvwrapper
fi

python() {
    if [ "$#" -eq 0 ]; then
        PYTHONSTARTUP=~/.pythonrc $(type -P python)
    else
        $(type -P python) "$@"
    fi
}

macupdate() {
    softwareupdate -a -i

    mas upgrade

    brew update
    brew upgrade

    brew cask upgrade
}

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | awk '{print $NF}')"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
