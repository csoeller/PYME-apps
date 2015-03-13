#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
export PYMEZYLAMAPDIR=/Users/csoe002/Documents/data/LM/Zyla/maps/blemishcurrent
PYTHONPATH=$HOME/Documents/src/PYMEcurrent/:$HOME/Documents/src/PYME-nf/ dh5view.py "$*"
    
#echo 'Arguments'
#echo $*
