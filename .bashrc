if [[ -n "$PS1" ]] 
then


# https://gist.github.com/zeroeth/1262447 -- check out


setbg() {
  osascript -e "tell application \"iTerm\"
    set current_terminal to (current terminal)
    tell current_terminal
      set current_session to (current session)
      tell current_session
        set background color to $1
      end tell
    end tell
  end tell"
}


# su() {
#   ( setbg "{15000,0,0}" & )
#   ( exec su $* )
#   ( setbg "{0,0,0}" & )
# }


    set -o notify

   if [[ $TERM = 'xterm-256color' ]]
   then
       # Reset prompt foreground color before running command
       trap 'echo -ne "\033[0m"' DEBUG
   fi

   pman(){
       man -t $@ | open -f -a /Applications/Preview.app
   }

   tman(){
       MANWIDTH=160 MANPAGE='col -bx' man $@ | mate
   }

   quit() {
       for app in $*
       do
           osascript -e "quit app \"$app\""
       done
   }

   terminal_title(){
       local t="$*"
       # [[ -n $t ]] && t=" - $t"
       [[ -z $t ]] && t=`hostname`
       echo -n -e "\033]0;$t\007"
   }

   ssh() {
       terminal_title "ssh $*"
       command ssh $*
       terminal_title
   }

   alias emcas=emacs
   alias ls='ls -F'
   alias ll="ls -l"
   alias more=less

   [[ -e "$DEV_HELPERS_FILE" ]] && source "$DEV_HELPERS_FILE"
   [[ -e ~/.git-completions.bash ]] && source ~/.git-completions.bash 

fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
