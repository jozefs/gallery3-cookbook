#!/bin/bash

# username and server URL where the box will be uploaded
SERVER=jozef@localhost

# path in the remote file system where boxes are kept
REMOTE_PATH=/tmp/boxes

# public-facing name of the box
PUBLIC_BOX_NAME=gallery3dev.box

function echo_and_send {
    ssh $SERVER "sh -x -c '$1'"
}

function check_usage {
    if [[ -z "$1" ]] ; then
        echo "Usage: `basename $0` <box-path>"
        exit 1
    fi
}

check_usage $1

# upload box
scp $1 $SERVER:$REMOTE_PATH

# save link to old box
echo_and_send "ln -s `readlink $REMOTE_PATH/$PUBLIC_BOX_NAME` $REMOTE_PATH/previous"

# symlink in new box
echo_and_send "ln -fs $REMOTE_PATH/$1 $REMOTE_PATH/$PUBLIC_BOX_NAME"

# remove old box
echo_and_send "rm `readlink $REMOTE_PATH/previous`; rm $REMOTE_PATH/previous"
