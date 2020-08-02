set -o extendedglob
fpath=(~/.zfuncs $fpath)
autoload -U $( cd ~/.zfuncs && echo ^*.zwc )

