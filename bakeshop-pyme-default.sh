#!/bin/bash
PATH="${HOME}/anaconda/bin:${PATH}"
export ETS_TOOLKIT=wx

eval "$(conda shell.bash hook)"
conda activate pyme-default-plain

(nohup bakeshop "$*" >"/tmp/bakeshop-$BASHPID.tmp" 2>&1 &)

