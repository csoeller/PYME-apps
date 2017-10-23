#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

export PYTHONPATH=$HOME/Documents/src/PYME-extra
echo "Opening $1..."

(nohup VisGUI.py "$*" >"/tmp/visgui-$BASHPID.tmp" 2>&1 &)
