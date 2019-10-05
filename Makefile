PLATYPUS='/usr/local/bin/platypus'
PLATYPUSORI='/usr/local/bin/platypus.orig'
PLATICNS='/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'
APPDIR='/Applications'
PDIR='PYMEapps'
SCRIPTPATH='$${HOME}/anaconda/bin:$${PATH}'
LOCALICONS=icons

all: VisGui.app	dh5view.app showXML.app VisGuiDef.app launchWorkers.app killLaunchWorkers.app dh5viewDef.app notebookServer.app launchnotebook.app launchWorkers-pyme-default.app killLaunchWorkers-pyme-default.app VisGuiDefR.app

launchWorkers-pyme-default.sh killLaunchWorkers-pyme-default.sh dh5view.sh visgui.sh dh5view-pyme-default.sh visgui-pyme-default.sh killLaunchWorkers.sh launchWorkers.sh notebookserver.sh notebookserver-pyme-default.sh visgui-pyme-default-recipe.sh: gen_script.py
	python gen_script.py -p $(SCRIPTPATH) $@ > $@

launchWorkers-pyme-default.app: launchWorkers-pyme-default.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-launcher-default.icns  -a 'launchWorkers-pyme-default' -o 'Text Window' -p '/bin/bash' -y 'launchWorkers-pyme-default.sh'

killLaunchWorkers-pyme-default.app: killLaunchWorkers-pyme-default.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'killLaunchWorkers-pyme-default' -o 'Text Window' -p '/bin/bash' -y 'killLaunchWorkers-pyme-default.sh'

VisGui.app: visgui.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-v.icns  -a 'VisGui' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|h5r' -y 'visgui.sh'

VisGuiDef.app: visgui-pyme-default.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-v-default.icns  -a 'VisGuiDef' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|h5r' -y 'visgui-pyme-default.sh'

VisGuiDefR.app: visgui-pyme-default-recipe.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-v-default.icns  -a 'VisGuiDefR' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|h5r' -y 'visgui-pyme-default-recipe.sh'

dh5view.app: dh5view.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-d.icns  -a 'dh5view' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|tif|lsm|h5|psf' -y 'dh5view.sh'

dh5viewDef.app: dh5view-pyme-default.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-d-default.icns  -a 'dh5viewDef' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|tif|lsm|h5|psf' -y 'dh5view-pyme-default.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py

showXML.app: showXML.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'showXML' -o 'Text Window' -p '/bin/bash' -X '*|xml'  -y 'showXML.sh'

launchWorkers.app: launchWorkers.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-launcher.icns  -a 'launchWorkers' -o 'Text Window' -p '/bin/bash' -y 'launchWorkers.sh'

killLaunchWorkers.app: killLaunchWorkers.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/pyme-launcher.icns  -a 'killLaunchWorkers' -o 'Text Window' -p '/bin/bash' -y 'killlaunchWorkers.sh'


# utilities for iPython (no jupyter) notebooks

notebookServer.app: notebookserver.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/ipython.icns  -a 'notebookServer' -o 'Text Window' -p '/bin/bash' -y 'notebookserver.sh'

notebookServerDef.app: notebookserver-pyme-default.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/ipython.icns  -a 'notebookServerDef' -o 'Text Window' -p '/bin/bash' -y 'notebookserver-pyme-default.sh'

launchnotebook.app: launchnotebook.sh
	$(PLATYPUS) -D  -i $(LOCALICONS)/ipython.icns -R -a 'launchnotebook'  -o 'Text Window'  -p '/bin/bash'  -T 'public.item|public.folder'  'launchnotebook.sh'

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
