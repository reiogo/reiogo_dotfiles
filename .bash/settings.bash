HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
SAVEHIST=$HISTSIZE
shopt -s histappend # append to history file
export HISTIGNORE='&:clear:ls:cd:[bf]g:exit:[ t\]*'

export EDITOR=vim

#User info

export USERNAME="Ray Ogoda"
export NICKNAME="Ray"

#Welcome message
echo -ne "Hey $NICKNAME! It's currently: "; date

#Start in Tmux
case $- in *i*)
    [ -z "$TMUX" ] && exec tmux
esac
