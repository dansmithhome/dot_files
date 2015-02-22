

alias emcas=emacs
alias ls='ls -F'
alias ll="ls -l"
alias more=less

set -o extendedglob

fpath=(~/.zfuncs $fpath)
autoload -U $( cd ~/.zfuncs && echo ^*.zwc )

# enable git completions
autoload -U compinit && compinit

compdef _cd_try_without_cdpath cd pushd


function precmd
{
  local GIT_BRANCH=$( git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s;* \(.*\);\1:;" )
  PS1=%B%m%(1j.(%j).)\ $GIT_BRANCH%1~%(!.#.\$)\ %b

  type terminal_title > /dev/null 2>&1 && terminal_title ${HOST}:$( pwd )
}






