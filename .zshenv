

alias emcas=emacs
alias ls='ls -F'
alias ll="ls -l"
alias more=less
alias sql="noglob sql"

set -o extendedglob

fpath=(~/.zfuncs $fpath)
autoload -U $( cd ~/.zfuncs && echo ^*.zwc )

# enable git completions
autoload -U compinit && compinit

compdef _cd_try_without_cdpath cd pushd


function precmd
{
  local GIT_SUMMARY=
  local GIT_REPO=$( git rev-parse --show-toplevel 2> /dev/null)

  if [[ -n ${GIT_REPO} ]]
  then
      GIT_REPO=$( basename ${GIT_REPO} )
      GIT_BRANCH=$( git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s;* \(.*\);\1;" -e 's/.*detached from \([0-9]*\).*$/Detached-\1:/ ' )
      GIT_SUMMARY="$GIT_REPO:$GIT_BRANCH "
  fi

  # higgins(2) dansmith:master ~$
  PS1=%B%m%(1j.(%j).)\ ${GIT_SUMMARY}%1~%(!.#.\$)\ %b

  # server:server ~$
  PS1=%B${GIT_SUMMARY}%1~%(!.#.\$)\ %b


  type terminal_title > /dev/null 2>&1 && terminal_title ${HOST}:$( basename $PWD )
}






