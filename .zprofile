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






[[ -f ~/.aws/credentials ]] && export AWS_CREDENTIALS=~/.aws/credentials


export CDPATH=.:~:..:~/src
export DEV_HELPERS_FILE=
export CLICOLOR=1
export EDITOR=emacs
export FIGNORE=\~:.o:.svn:DS_Store
export GREP_OPTIONS='--color=auto --directories=skip'
export HISTFILE=~/.zsh-history
export HISTSIZE=10000
export HOST=$(hostname -s)
export LESS='--quit-if-one-screen --ignore-case --quiet --quit-at-eof --dumb --tilde --no-init --RAW-CONTROL-CHARS'
export LSCOLORS=exfxcxdxbxegedabagexex
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export SAVEHIST=9999999
export VISUAL=emacs

export JAVA_HOME;  JAVA_HOME=$(test -x /usr/libexec/java_home && /usr/libexec/java_home --task CommandLine)

if [[ -t 0 ]]
then
    export SSH_AGENT_PID_FILE=~/.ssh-agent-pid-$(hostname -s)

    if ! pgrep -q -F ${SSH_AGENT_PID_FILE} ssh-agent
    then
        eval $( ssh-agent ) > /dev/null
        echo ${SSH_AGENT_PID} > ${SSH_AGENT_PID_FILE}
    else
        export SSH_AGENT_PID=$(< ${SSH_AGENT_PID_FILE} )
    fi
fi



case $( hostname -s ) in
    dv)  # dataverse host
        [[ -z ${SSH_AGENT_PID} ]] && eval $(keychain --quiet --eval --agents ssh dansmith-pki-github-id_rsa)
        ;;

    Dans-MBP|dans-mbp|Dans-MacBook-Pro|higgins)  # PKI laptop
        [[ -z ${SSH_AGENT_PID} ]] && ssh-add -k ~/.ssh/carc_q ~/.ssh/github-dansmithhome_e ~/.ssh/github-dansmith-pki_m

	    ;;

    Bosco|dan-macbook-pro)   # laptop
        [[ -z ${SSH_AGENT_PID} ]] && ssh-add ~/.ssh/carc_q ~/.ssh/github-dansmithhome_e ~/.ssh/github-dansmith-pki_m
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
        [[ -z ${SSH_AGENT_PID} ]] && ssh-add ~/.ssh/carc-git ~/.ssh/github-dansmithhome_e ~/.ssh/id_dsa 
        ;;
esac

# Chef 
prepend-to-path /opt/chefdk/embedded/bin
prepend-to-path /opt/chefdk/bin
prepend-to-path ~/.chefdk/gem/ruby/2.1.0/bin


prepend-to-path /usr/local/bin
append-to-path  /usr/local/git/bin
append-to-path  ~/.rvm/bin 
append-to-path  /usr/local/heroku/bin


# source-if-exists ${BASH_ENV}
source-if-exists ${DEV_HELPERS_FILE}
source-if-exists ~/.rvm/scripts/rvm


# show any detached screen sessions
screen -ls | grep Detached
