#!/bin/bash
HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
SAVEHIST=$HISTSIZE
shopt -s histappend # append to history file
export HISTIGNORE='&:clear:ls:cd:[bf]g:exit:[ t\]*'

export EDITOR=vim


#Attempting to set konsole color based on the time.
h=`date +%k`
if [ $h -gt 19 ]; then
    konsoleprofile colors=srcery
elif [ $h -gt 17 ] ; then
    konsoleprofile colors=Solarized
else
    konsoleprofile colors=SolarizedLight
fi


#User info

export USERNAME="Ray Ogoda"
export NICKNAME="Ray"

#Welcome message
echo -ne "Hey $NICKNAME! It's currently: "; date

