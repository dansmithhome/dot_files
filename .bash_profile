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
export PATH; PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export VISUAL=emacs



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

#
#  Set host-specific values
#

export H="UNKNOWN-HOST"

case `hostname -s` in
    Bosco)   # laptop
       H='bosco'
       ;;

    new-dev)  # New Development
	   H='new-dev'
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

    alex-dev|domU-12-31-39-13-D6-62)  # Development
	   H='dev'
       export ALEX_LIB=/mnt/www/sites/alex/lib
       export DEV_HELPERS_FILE=~/.bashrc-alex-helpers
	   export EC2_HOME=~/ec2-api-tools-1.3-36506
	   export EC2_PRIVATE_KEY=~/.ec2/pk-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   export EC2_CERT=~/.ec2/cert-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   append-to-path $EC2_HOME/bin

       if [ -f /usr/bin/keychain ]
       then
           eval `/usr/bin/keychain --eval --agents ssh --quiet`
           ssh-add -l > /dev/null || ssh-add
       fi
	   ;;

    askalexander|conjuringarts)   # Production
       H='carc'
       export ALEX_LIB=/mnt/www/sites/alex/lib
       export DEV_HELPERS_FILE=~/.bashrc-alex-helpers
	   export EC2_HOME=~/ec2-api-tools-1.3-36506
	   export EC2_PRIVATE_KEY=~/.ec2/pk-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   export EC2_CERT=~/.ec2/cert-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem	   
       append-to-path "${EC2_HOME}/bin"

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

source-if-exists ${BASH_ENV}
source-if-exists ${DEV_HELPERS_FILE}
source-if-exists ~/.rvm/scripts/rvm

# show any detached screen sessions
screen -ls | grep Detached
