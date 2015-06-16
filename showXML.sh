#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

# echo $PATH
# echo $PYTHONPATH
FNAME=$1
# export PYTHONPATH=/Users/csoelle/Documents/src/PYME-nf/
python - <<EOF
import time
from PYME.Acquire import MetaDataHandler
mdh =  MetaDataHandler.XMLMDHandler("$FNAME")
print mdh
try:
    print 'StartTime in date format: %s' % time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(mdh['StartTime']))
except:
    pass

try:
    print 'Source.StartTime in date format: %s' % time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(mdh['Source.StartTime']))
except:
    pass

EOF

#echo 'Arguments'
#echo $*
