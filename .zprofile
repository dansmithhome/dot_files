
[[ -f ~/.aws/credentials ]] && export AWS_CREDENTIALS=~/.aws/credentials
[[ -x /usr/libexec/java_home ]] && export JAVA_HOME=$(/usr/libexec/java_home --task CommandLine)

export CDPATH=.:~:..:~/p
export CLICOLOR=1
export EDITOR=emacs
export FIGNORE=\~:.o:.svn:DS_Store
export GREP_OPTIONS='--color=auto --directories=skip'
export GOPATH=~/p/golang
export HISTFILE=~/.zsh-history
export HISTSIZE=10000
export HOST=$(hostname -s)
export LESS='--quit-if-one-screen --ignore-case --quiet --quit-at-eof --dumb --tilde --no-init --RAW-CONTROL-CHARS'
export LSCOLORS=xxxxxxxxxxxxxxxxxxxxxx   # no colors in ls, thank you.
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export SAVEHIST=9999999
export SHELL=/bin/bash
export VISUAL=emacs

prepend-to-path /usr/local/go/bin
prepend-to-path /usr/local/bin
prepend-to-path /usr/local/opt
prepend-to-path /usr/local/sbin
append-to-path  ~/p/go/bin
append-to-path  /usr/local/git/bin
append-to-path ~/Dropbox/bin-alfred


for godirs in ${(ps.:.)GOPATH}
do
    append-to-path ${godirs}/bin
done
unset godirs


# source-if-exists 
source-if-exists ~/.rvm/scripts/rvm
source-if-exists ~/.cargo/env

# show detached screen sessions
screen -ls | grep Detached
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"


if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
