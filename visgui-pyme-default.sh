#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"
source activate pyme-default
export PYTHONPATH=$HOME/Documents/src/PYME-src/PYME-extra
echo "Opening $1..."

(nohup VisGUI "$*" >"/tmp/visgui-$BASHPID.tmp" 2>&1 &)
