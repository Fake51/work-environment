#!/bin/bash
DIR=`dirname $0`
DESTINATION=~/.config/terminator/

if [ ! -d $DESTINATION ]
then
    mkdir -p $DESTINATION
fi

cp $DIR/config $DESTINATION
