#!/bin/bash
if [ -z "$TERMINATOR_PROFILE" -o "$TERMINATOR_PROFILE" = 'solarized-dark' ]
then
    PROFILE='solarized-light'
else
    PROFILE='solarized-dark'
fi

/usr/bin/tmux setenv -g TERMINATOR_PROFILE $PROFILE
/home/peter/bin/tmux-command.sh "export TERMINATOR_PROFILE=$PROFILE"
