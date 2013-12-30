if [[ -n "$PS1" ]] 
then

    set -o notify

    parse_git_branch ()
    {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
    }

    if [[ ${TERM} = 'xterm-256color' || ${TERM} = 'screen' ]]
    then
       export PS1='\[\033[1;30m\]$H$(parse_git_branch) \W\$ '

       # Reset prompt foreground color before running command
       trap 'echo -ne "\033[0m"' DEBUG
    else
        export PS1='$H$(parse_git_branch) \W\$ '
    fi

   alias emcas=emacs
   alias ls='ls -F'
   alias ll="ls -l"
   alias more=less

   [[ -e "$DEV_HELPERS_FILE" ]] && source "$DEV_HELPERS_FILE"

   [[ -e ~/.git-completions.bash ]] && source ~/.git-completions.bash 

   [[ `uname -s` = 'Darwin' ]] && source ~/.bash_apple

fi

