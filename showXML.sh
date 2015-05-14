#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

# echo $PATH
# echo $PYTHONPATH
FNAME=$1
export PYTHONPATH=/Users/csoelle/Documents/src/PYME-nf/
export python - <<EOF
from PYME.Acquire import MetaDataHandler
print MetaDataHandler.XMLMDHandler("$FNAME")
EOF

#echo 'Arguments'
#echo $*
