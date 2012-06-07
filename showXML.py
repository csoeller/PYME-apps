import sys
if len(sys.argv) < 2:
    filen = "(no argument given)"
else:
    filen = sys.argv[1]
from PYME.Acquire import MetaDataHandler
print MetaDataHandler.XMLMDHandler(filen)
