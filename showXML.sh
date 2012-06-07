#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
PYTHONPATH=/Users/csoelle/Documents/src/PYMEcurrent/:/Users/csoelle/Documents/src/PYME-nf/ python /Users/csoelle/Documents/src/PYMEapps/showXML.py $*
#echo 'Arguments'
#echo $*
