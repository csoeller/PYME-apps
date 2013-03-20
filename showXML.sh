#!/bin/bash
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# echo $PATH
# echo $PYTHONPATH
FNAME=$1
PYTHONPATH=/Users/csoelle/Documents/src/PYME-nf/ python - <<EOF
from PYME.Acquire import MetaDataHandler
print MetaDataHandler.XMLMDHandler("$FNAME")
EOF
#echo 'Arguments'
#echo $*
