#!/bin/bash
export PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PYMENASPATH=/mnt/smb/nas2/
PYTHONPATH=/Users/csoelle/Documents/src/PYME-nf/ urlOpener.py $*
# echo $PATH
# echo $PYTHONPATH
#echo 'Arguments'
#echo $*
