#
#  Set host-specific values
#

# Usage: find_existing_dir dir1 dir2 ...
#        Prints name of first directory that exists
function find_existing_dir
{
    for dir in $*
    do
        if [[ -d ${dir} ]]
        then
            echo ${dir}
            return
        fi
    done
    echo "Warning: No matching directories: $*" 1>&2
    echo "missing-directory"
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




export CDPATH=.:~:..:~/src
export DEV_HELPERS_FILE=
export CLICOLOR=1
export EDITOR=emacs
export FIGNORE=\~:.o:.svn:DS_Store
export GREP_OPTIONS='--color=auto'
export HISTFILE=~/.zsh-history
export HISTSIZE=10000
export HOST=$(hostname -s)
export LESS='--quit-if-one-screen --ignore-case --quiet --quit-at-eof --dumb --tilde --no-init --RAW-CONTROL-CHARS'
export LSCOLORS=exfxcxdxbxegedabagexex
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export SAVEHIST=9999999
export VISUAL=emacs

export JAVA_HOME;  JAVA_HOME=$(test -x /usr/libexec/java_home && /usr/libexec/java_home --task CommandLine)
export M2_HOME;    M2_HOME=$(find_existing_dir /usr/local/apache-maven/apache-maven-3.2.3 /mnt/maven )
export M2;         M2=${M2_HOME}/bin
export MAVEN_OPTS; MAVEN_OPTS=
PATH+=:$M2

case `hostname -s` in
    dv)  # dataverse host
        ;;

    Dans-MBP|dans-mbp|Dans-MacBook-Pro|higgins)  # PKI laptop
	    ;;

    Bosco|dan-macbook-pro)   # laptop
       ;;

    dev|askalexander|conjuringarts) 
       export ALEX_LIB=/mnt/www/sites/alex/lib
       export DEV_HELPERS_FILE=~/.bashrc-alex-helpers
	   export EC2_HOME=~/ec2-api-tools-1.3-36506
	   export EC2_PRIVATE_KEY=~/.ec2/pk-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   export EC2_CERT=~/.ec2/cert-NCS6VCSRTWMVTHCIQM2LMAEA6BE2HJBU.pem
	   append-to-path ${EC2_HOME}/bin
	   ;;

    *)
      echo .zshenv: Unknown host. Cannot customize host environment.
       ;;
esac

prepend-to-path /usr/local/bin
append-to-path  /usr/local/git/bin
append-to-path  ~/.rvm/bin 
append-to-path  /usr/local/heroku/bin


if [ -f ~/bin/keychain ]
then
    eval $(~/bin/keychain --eval --agents ssh --quiet carc-git github-dansmithhome id_dsa )
    ssh-add -l > /dev/null || ssh-add
else 
    ssh-add -l > /dev/null 2>&1 || eval $( ssh-agent ) > /dev/null
fi


# source-if-exists ${BASH_ENV}
source-if-exists ${DEV_HELPERS_FILE}
source-if-exists ~/.rvm/scripts/rvm


# show any detached screen sessions
screen -ls | grep Detached
