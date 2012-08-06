#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
PYTHONPATH=$HOME/Documents/src/PYMEcurrent/:/Users/csoelle/Documents/src/PYME-nf/ python $HOME/Documents/src/PYMEapps/showXML.py $*
#echo 'Arguments'
#echo $*
