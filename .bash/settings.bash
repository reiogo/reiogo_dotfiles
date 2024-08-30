#!/bin/bash
HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
SAVEHIST=$HISTSIZE
shopt -s histappend # append to history file
export HISTIGNORE='&:clear:ls:cd:[bf]g:exit:[ t\]*'

export EDITOR=vim
set -o vi


#Attempting to set konsole color based on the time.
h=`date +%k`
if [ $h -gt 22 ]; then
    konsoleprofile colors=Gruvbox
elif [ $h -lt 7 ] ; then
    konsoleprofile colors=Gruvbox
elif [ $h -gt 16 ] ; then
    konsoleprofile colors=Solarized
else
    konsoleprofile colors=SolarizedLight
fi


#User info

export USERNAME="Ray Ogoda"
export NICKNAME="Ray"

#Welcome message
echo -ne "Hey $NICKNAME! It's currently: "; date

