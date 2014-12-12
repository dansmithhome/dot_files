export CDPATH=.:~:..:~/src
export DEV_HELPERS_FILE=
export CLICOLOR=1
export EDITOR=emacs
export FIGNORE=\~:.o:.svn:DS_Store
export GREP_OPTIONS='--color=auto'
export HISTSIZE=10000
export HOST=$(hostname -s)
export LESS='--quit-if-one-screen --ignore-case --quiet --quit-at-eof --dumb --tilde --no-init --RAW-CONTROL-CHARS'
export LSCOLORS=exfxcxdxbxegedabagexex
export PATH; PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export VISUAL=emacs

export JAVA_HOME;  JAVA_HOME=$(test -x /usr/libexec/java_home && /usr/libexec/java_home --task CommandLine)
export M2_HOME;    M2_HOME=/usr/local/apache-maven/apache-maven-3.2.3
export M2;         M2=${M2_HOME}/bin
export MAVEN_OPTS; MAVEN_OPTS=

fpath=(~/.zfuncs $fpath)
autoload -U go mvn sql 

# enable git completions
autoload -U compinit && compinit


PATH=$PATH:$M2

function precmd
{
  local GIT_BRANCH=$( git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s;* \(.*\);\1:;" )
  PS1=%B%m%(1j.(%j).)\ $GIT_BRANCH%1~%(!.#.\$)\ %b
}






function source-if-exists {
    [[ -s "${1}" ]] && source "${1}"
}

function append-to-path {
    [[ -d "${1}" ]] && PATH="${PATH}:${1}"
}

function prepend-to-path {
    [[ -d "${1}" ]] && PATH="${1}:${PATH}"
}

prepend-to-path /usr/local/bin
append-to-path  /usr/local/git/bin
append-to-path  ~/.rvm/bin 
append-to-path  /usr/local/heroku/bin


if [ -f ~/bin/keychain ]
then
    eval $(~/bin/keychain --eval --agents ssh --quiet carc-git github-dansmithhome id_dsa )
    ssh-add -l > /dev/null || ssh-add
fi


# source-if-exists ${BASH_ENV}
source-if-exists ${DEV_HELPERS_FILE}
source-if-exists ~/.rvm/scripts/rvm

