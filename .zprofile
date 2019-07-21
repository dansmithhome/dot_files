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


export CDPATH=.:~:..:~/p
export DEV_HELPERS_FILE=
export CLICOLOR=1
export EDITOR=emacs
export FIGNORE=\~:.o:.svn:DS_Store
export GREP_OPTIONS='--color=auto --directories=skip'
export GOPATH=~/p/golang
export HISTFILE=~/.zsh-history
export HISTSIZE=10000
export HOST=$(hostname -s)
export LESS='--quit-if-one-screen --ignore-case --quiet --quit-at-eof --dumb --tilde --no-init --RAW-CONTROL-CHARS'
export LSCOLORS=xxxxxxxxxxxxxxxxxxxxxx   # no colors in ls, thank you.
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export SAVEHIST=9999999
export SHELL=/bin/bash
export VISUAL=emacs

if ! test -x /usr/libexec/java_home && /usr/libexec/java_home --task CommandLine 2> /dev/null
then
    export JAVA_HOME;  JAVA_HOME=$(test -x /usr/libexec/java_home && /usr/libexec/java_home --task CommandLine)
fi

function setup-ssh
{
    # Share a single ssh-agent per machine.
    # usage: setup_ssh ssh-file ssh-file ...

    if [[ -n ${SSH_AUTH_SOCK} ]]
    then
        local file files_to_add
        declare -a files_to_add
        for file in $*
        do
            ssh-add -l | awk '$3 == "'${file}'" { exit 3}'
            if [[ $? -eq 0 ]]; then
               files_to_add+=${file}
            fi
        done
        [[ -n ${files_to_add} ]] && ssh-add ${files_to_add}
        return
    fi
    
    export SSH_AGENT_PID_FILE=~/.ssh-agent-pid-$(hostname -s)

    if [[ ! -f ${SSH_AGENT_PID_FILE} ]] || ! pgrep -q -F ${SSH_AGENT_PID_FILE} ssh-agent
    then
        # Create new ssh agent
        eval $( ssh-agent ) > /dev/null
        echo ${SSH_AGENT_PID} > ${SSH_AGENT_PID_FILE}
        [[ -n $* ]] && ssh-add $*

    else
        # Use existing ssh agent
        export SSH_AGENT_PID=$(< ${SSH_AGENT_PID_FILE} )
    fi
}

case $( hostname -s ) in

    lt-*|Talma|Bosco|dan-macbook-pro)   # personal laptop
        setup-ssh ~/.ssh/github-dansmithhome_e
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
        setup-ssh {carc-git,github-dansmithhome_e,id_dsa}
        ;;
esac


# aws completer
[[ -f $( whence aws_zsh_completer.sh ) ]] && source $( whence aws_zsh_completer.sh )


# go
prepend-to-path /usr/local/go/bin


prepend-to-path ~/anaconda2/bin
prepend-to-path /usr/local/bin
prepend-to-path /usr/local/opt
prepend-to-path /usr/local/sbin
append-to-path  ~/p/go/bin
append-to-path  /usr/local/git/bin
append-to-path  /usr/local/opt/scala/bin


for godirs in ${(ps.:.)GOPATH}
do
    append-to-path ${godirs}/bin
done
unset godirs


# source-if-exists ${BASH_ENV}
source-if-exists ${DEV_HELPERS_FILE}
source-if-exists ~/.rvm/scripts/rvm
source-if-exists ~/.config/exercism/exercism_completion.zsh 
source-if-exists ~/.cargo/env

# show any detached screen sessions
screen -ls | grep Detached
