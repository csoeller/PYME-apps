# edit these for local machine
SCRIPTPATH='$${HOME}/miniconda3/bin:$${PATH}'

# these should generally work
PLATYPUS='/usr/local/bin/platypus'
PLATYPUSORI='/usr/local/bin/platypus.orig'
PLATICNS='/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'
APPDIR='/Applications'
PDIR='PYMEapps'
LOCALICONS=icons
LOCALBASH='/opt/local/bin/bash'
SYSTEMBASH='/bin/bash'

all: VisGui.app	dh5view.app showXML.app launchWorkers.app killLaunchWorkers.app notebookServer.app launchnotebook.app bakeshop.app

launchWorkers-pyme-env.sh killLaunchWorkers-pyme-env.sh dh5view.sh visgui.sh dh5view-pyme-env.sh visgui-pyme-env.sh killLaunchWorkers.sh launchWorkers.sh notebookserver.sh notebookserver-pyme-env.sh visgui-pyme-env-recipe.sh bakeshop-pyme-env.sh: gen_script.py
	python gen_script.py -p $(SCRIPTPATH) $@ > $@

VisGui.app: visgui-pyme-env.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-v-default.icns  -a 'VisGui' -o 'Progress Bar' -p $(LOCALBASH) -X '*|h5r' -y 'visgui-pyme-env.sh'

dh5view.app: dh5view-pyme-env.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-d-default.icns  -a 'dh5view' -o 'Progress Bar' -p $(LOCALBASH) -X '*|tif|lsm|h5|psf' -y 'dh5view-pyme-env.sh'

bakeshop.app:  bakeshop-pyme-env.sh
	$(PLATYPUS) -D  -a 'bakeshop' -o 'Progress Bar' -p $(LOCALBASH) -y 'bakeshop-pyme-env.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py

showXML.app: showXML.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'showXML' -o 'Text Window' -p $(SYSTEMBASH) -X '*|xml'  -y 'showXML.sh'

launchWorkers.app: launchWorkers-pyme-env.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-launcher-default.icns  -a 'launchWorkers' -o 'Text Window' -p $(SYSTEMBASH) -y 'launchWorkers-pyme-env.sh'

killLaunchWorkers.app: killLaunchWorkers-pyme-env.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'killLaunchWorkers' -o 'Text Window' -p $(SYSTEMBASH) -y 'killLaunchWorkers-pyme-env.sh'


# utilities for iPython/jupyter notebooks

notebookServer.app: notebookserver-pyme-env.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/ipython.icns  -a 'notebookServer' -o 'Text Window' -p $(SYSTEMBASH) -y 'notebookserver-pyme-env.sh'

launchnotebook.app: launchnotebook.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/ipython.icns -R -a 'launchnotebook'  -o 'Text Window'  -p $(SYSTEMBASH)  -T 'public.item|public.folder'  'launchnotebook.sh'

install: all
	if [ -e $(APPDIR)/$(PDIR).old ] ; \
	then \
		trash -v $(APPDIR)/$(PDIR).old ;\
	fi
	if [ -e $(APPDIR)/$(PDIR) ] ; \
	then \
		mv $(APPDIR)/$(PDIR) $(APPDIR)/$(PDIR).old ;\
	fi
	mkdir $(APPDIR)/$(PDIR)
	rsync -av VisGui.app dh5view.app showXML.app $(APPDIR)/$(PDIR)
