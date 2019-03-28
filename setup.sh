#!/bin/bash

# Creates a link from $1 to $2, and 
f_link()
{
    ln -is $1 $2
}

# Create link to .zshrc
f_link `pwd`/.zshrc ${HOME}/.zshrc

# Create link to .screenrc
f_link `pwd`/.screenrc ${HOME}/.screenrc

# Create link to .tmux.conf
f_link `pwd`/.tmux.conf ${HOME}/.tmux.conf

HOST=`hostname`
if [[ -d ./${HOST} ]]; then
    # Link to individual files in ${HOST}
    cd ./${HOST} && for file in `find . -type f`; do \
        echo Linking ${file}; \
        src=`pwd`/${file}
        dest=${HOME}/${file}
        f_link `realpath -s ${src}` `realpath -s ${dest}`; \
    done
fi
