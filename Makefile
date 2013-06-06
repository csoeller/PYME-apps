PLATYPUS='/usr/local/bin/platypus'
PLATICNS='/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'
APPDIR='/Applications'
PDIR='PYMEapps'

all: VisGui.app	dh5view.app PYMEurlOpener.app showXML.app

VisGui.app: visgui.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'VisGui' -o 'Progress Bar' -p '/bin/bash' -X '*|h5r' -T '****|fold'  -y 'visgui.sh'

dh5view.app: dh5view.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'dh5view' -o 'Progress Bar' -p '/bin/bash' -X '*|tif|lsm|h5|psf' -T 'public.tiff'  -y 'dh5view.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py

showXML.app: showXML.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'showXML' -o 'Text Window' -p '/bin/bash' -X '*|xml' -T '****|fold|public.xml'  -y 'showXML.sh'

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
	rsync -av VisGui.app dh5view.app PYMEurlOpener.app showXML.app $(APPDIR)/$(PDIR)
