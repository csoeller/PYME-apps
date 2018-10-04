#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"
source activate pyme-default
export PYTHONPATH=$HOME/Documents/src/PYME-src/PYME-extra
echo "Opening $1..."

(nohup dh5view "$*" >"/tmp/dh5view-$BASHPID.tmp" 2>&1 &)
