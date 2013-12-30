export BASH_ENV=~/.bashrc
export CDPATH=.:~:..
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


function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

PS1="\w \$(parse_git_branch)\$ "
if [[ ${TERM} = 'xterm-256color' ]]
then
    export PS1='\[\033[1;30m\]$H$(parse_git_branch) \W\$ '
else
    export PS1='$H$(parse_git_branch) \W\$ '
fi

function append-to-path {
    [[ -d "${1}" ]] && PATH="${PATH}:${1}"
}

function prepend-to-path {
    [[ -d "${1}" ]] && PATH="${1}:${PATH}"
}



prepend-to-path /usr/local/bin
append-to-path  /usr/local/git/bin
append-to-path  ~/.rvm/bin 


#
#  Set host-specific values
#

export H="UNKNOWN-HOST"

case `hostname -s` in
    Bosco*|bosco*)   # laptop
       H='bosco'
       ;;

    alex-dev|domU-12-31-39-13-D6-62)  # Development
	   H='dev'
       export ALEX_LIB=/mnt/www/sites/alex/lib
       export DEV_HELPERS_FILE=~/.bashrc-alex-helpers
	   export EC2_HOME=~/ec2-api-tools-1.3-36506
	   export EC2_PRIVATE_KEY=~/.ec2/pk-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   export EC2_CERT=~/.ec2/cert-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   append-to-path $EC2_HOME/bin
       if [ -e ~/ImageMagick-6.4.8 ] 
       then
           export MAGICK_HOME=~/ImageMagick-6.4.8/
           export DYLD_LIBRARY_PATH=~/ImageMagick-6.4.8//lib
           append-to-path ~/ImageMagick-6.4.8/bin
       fi
       if [ -f /usr/bin/keychain ]
       then
           eval `/usr/bin/keychain --eval --agents ssh --quiet`
           ssh-add -l > /dev/null || ssh-add
       fi
	   ;;

    conjuringarts)   # Production
       H='carc'
       export ALEX_LIB=/mnt/www/sites/alex/lib
       export DEV_HELPERS_FILE=~/.bashrc-alex-helpers
	   export EC2_HOME=~/ec2-api-tools-1.3-36506
	   export EC2_PRIVATE_KEY=~/.ec2/pk-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   export EC2_CERT=~/.ec2/cert-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem	   
       append-to-path "${EC2_HOME}/bin"


       if [ -e ~/ImageMagick-6.4.8 ] 
       then
           export MAGICK_HOME=~/ImageMagick-6.4.8/
           export DYLD_LIBRARY_PATH=~/ImageMagick-6.4.8//lib
           append-to-path ~/ImageMagick-6.4.8/bin
       fi

       if [ -f /usr/bin/keychain ]
       then
           eval `/usr/bin/keychain --eval --agents ssh --quiet`
           ssh-add -l > /dev/null || ssh-add
       fi
	   ;;
    *)
      echo no match
       ;;
esac

[[ -e ${BASH_ENV} ]]         && source "${BASH_ENV}"
[[ -e ${DEV_HELPERS_FILE} ]] && source "${DEV_HELPERS_FILE}"



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


