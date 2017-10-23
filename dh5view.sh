#!/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

# echo $PATH
# echo $PYTHONPATH
export PYTHONPATH=$HOME/Documents/src/PYME-extra
echo "Opening $1..."

# This may need tweaking to something more like 
(nohup dh5view.py "$*" >"/tmp/dh5view-$BASHPID.tmp" 2>&1 &)
