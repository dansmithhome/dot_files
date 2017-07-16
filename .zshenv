

alias emcas=emacs
alias ls='ls -F'
alias ll="ls -l"
alias more=less
alias sql="noglob sql"

set -o extendedglob

fpath=(~/.zfuncs $fpath)
autoload -U $( cd ~/.zfuncs && echo ^*.zwc )

autoload -U colors && colors

# enable git completions
autoload -U compinit && compinit

compdef _cd_try_without_cdpath cd pushd

compctl -K _g_comp g


[[ -f /usr/local/share/zsh/site-functions/_awless ]] && source /usr/local/share/zsh/site-functions/_awless

[[ -n $EMACS ]] && unsetopt zle


function precmd
{
  local GIT_SUMMARY=
  local GIT_REPO=$( git rev-parse --show-toplevel 2> /dev/null)

  if [[ -n ${GIT_REPO} ]]
  then
      GIT_REPO=$( basename ${GIT_REPO} )
      # GIT_BRANCH=$( git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s;* \(.*\);\1;" -e 's/.*detached from \([0-9]*\).*$/Detached-\1:/ ' )
      GIT_BRANCH=$( git rev-parse --abbrev-ref HEAD 2> /dev/null)

      GIT_SUMMARY="$GIT_REPO:$GIT_BRANCH "
      # GIT_SUMMARY="$GIT_REPO:"
  fi

  # higgins(2) dansmith:master ~$
  # PS1=%B%m%(1j.(%j).)\ ${GIT_SUMMARY}%1~%(!.#.\$)\ %b

  # server:server ~$
  # PS1=%B${GIT_SUMMARY}%1~%(!.#.\$)\ %b

  # server:server ~ 1$


  local dirprompt=""
  if [[ $PWD == $HOME ]]
  then
      dirprompt='~'
  elif [[ $PWD == $p ]]
  then
      dirprompt='^'
  else
      dirprompt=$( basename $PWD )
  fi
  
  # PS1=%B${GIT_SUMMARY}%1~\ %(1j.%j.)%(!.#.\$)\ %b
  # PS1=%B${GIT_SUMMARY}${dirprompt}\ %(1j.%j.)%(!.#.\$)\ %b
  # PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
  PS1="%{$fg[blue]%}${GIT_SUMMARY}%{$reset_color%}%{$fg[yellow]%}${dirprompt}%{$reset_color%} %(1j.%j.)%(!.#.\$)%{$reset_color%} "

  type terminal_title > /dev/null 2>&1 && terminal_title ${HOST}:$( basename $PWD )
}






