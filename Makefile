PLATYPUS='/usr/local/bin/platypus'
PLATICNS='/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'
APPDIR='/Applications'
PDIR='PYMEapps'

all: VisGui.app	dh5view.app showXML.app VisGuiDef.app launchWorkers.app killLaunchWorkers.app dh5viewDef.app

VisGui.app: visgui.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'VisGui' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|h5r' -y 'visgui.sh'

VisGuiDef.app: visgui-pyme-default.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'VisGuiDef' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|h5r' -y 'visgui-pyme-default.sh'

dh5view.app: dh5view.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'dh5view' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|tif|lsm|h5|psf' -y 'dh5view.sh'

dh5viewDef.app: dh5view-pyme-default.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'dh5viewDef' -o 'Progress Bar' -p '/opt/local/bin/bash' -X '*|tif|lsm|h5|psf' -y 'dh5view-pyme-default.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py

showXML.app: showXML.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'showXML' -o 'Text Window' -p '/bin/bash' -X '*|xml'  -y 'showXML.sh'

launchWorkers.app: launchWorkers.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'launchWorkers' -o 'Text Window' -p '/bin/bash' -y 'launchWorkers.sh'

killLaunchWorkers.app: killLaunchWorkers.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'killLaunchWorkers' -o 'Text Window' -p '/bin/bash' -y 'killlaunchWorkers.sh'

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
