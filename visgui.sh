#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
# force file concatenation
export PYMEZYLAMAPDIR=/Users/csoe002/Documents/data/LM/Zyla/maps/blemishcurrent
PYTHONPATH=$HOME/Documents/src/PYMEcurrent/:$HOME/Documents/src/PYME-nf/ VisGUI.py "$*"
#echo 'Arguments'
#echo $*
