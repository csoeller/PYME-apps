#!/opt/local/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"

# echo $PATH
# echo $PYTHONPATH
FNAME=$1
# export PYTHONPATH=/Users/csoelle/Documents/src/PYME-nf/
python - <<EOF

import os

filename = "$FNAME"
root = '/Users/csoe002'
prefix = 'http://localhost:8888/notebooks/'

fname = os.path.abspath(filename)
if fname.startswith(os.path.abspath(root)+os.sep):
    relp = os.path.relpath(fname,root)
else:
    raise RuntimeError('%s does not start with root %s' % (fname,os.path.abspath(root)+os.sep))

urlpath = os.path.join(prefix, relp)

# and now launch the browser on our path
import webbrowser
webbrowser.open(urlpath,new=2)

EOF
