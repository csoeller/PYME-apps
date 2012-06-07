#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
PYTHONPATH=$HOME/Documents/src/PYMEcurrent/:$HOME/Documents/src/PYME-nf/ VisGUI.py $*
#echo 'Arguments'
#echo $*
