#!/bin/bash

# if address passed use address. Otherwise default to "umbrel@umbrel.local"
if [ -z "$1" ]; then
    echo "A user and host for the umbrel is required"
    exit 1
else
    ADDRESS="$1"
fi

# abort if path to ledger live not passed
if [ -z "$2" ]; then
    echo "a path to a ledger live executable is required"
    exit 1
fi

# ensure descriptors are passed
if [ -z "$3" ] || [ -z "$4" ] || [ -z "$5" ]; then
    echo "descriptor arguments are required"
    exit 1
fi

# run umbrel script and get results
ssh $ADDRESS 'bash -s' < umbrelscript # run umbrelscript on the remote ls
scp $ADDRESS:~/tmp2 ./ # pull tmp2 file to local repo
ssh $ADDRESS 'rm ~/tmp2' # clean up at the end

# run localscript
chmod 775 ./localscript #ensure executability
./localscript "$3" "$4" "$5"

# run lss and ledger live
# trying to run both at the same time, but can't get syntax right - not 100% whats wrong, but also not the most important part
# $HOME/lss/lss & EXPLORER=http://127.0.0.1:20000 $2 && fg
