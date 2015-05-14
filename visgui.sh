#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

export PYMEZYLAMAPDIR=/Users/csoe002/Documents/data/LM/Zyla/maps/blemishcurrent
export PYTHONPATH=$HOME/Documents/src/PYME-nf/
echo "Opening $1..."

(nohup VisGUI.py "$*" >"/tmp/visgui-$BASHPID.tmp" 2>&1 &)
