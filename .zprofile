#
#  Set host-specific values
#

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
      echo .zshenv: Unknown host. Cannot initialize host environment.
       ;;
esac




# show any detached screen sessions
screen -ls | grep Detached
