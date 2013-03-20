PLATYPUS='/usr/local/bin/platypus'
PLATICNS='/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'

all: VisGui.app	dh5view.app PYMEurlOpener.app showXML.app

VisGui.app: visgui.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'VisGui' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  -y 'visgui.sh'

dh5view.app: dh5view.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'dh5view' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  -y 'dh5view.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py

showXML.app: showXML.sh
	$(PLATYPUS) -D  -i $(PLATICNS)  -a 'showXML' -o 'Text Window' -p '/bin/bash' -X '*' -T '****|fold'  -y 'showXML.sh'
