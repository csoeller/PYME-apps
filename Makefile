PLATYPUS='/usr/local/bin/platypus'
VERSION='1.1'
all: VisGui.app	dh5view.app PYMEurlOpener.app

VisGui.app:
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'VisGui' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  -V $(VERSION) 'visgui.sh'

dh5view.app:
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'dh5view' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold' -V $(VERSION) 'dh5view.sh'

PYMEurlOpener.app: PYMEurlOpener.applescript pyme-urlopen.sh editplist_for_url.py
	/usr/bin/osacompile -o PYMEurlOpener.app PYMEurlOpener.applescript
	cp pyme-urlopen.sh PYMEurlOpener.app/Contents/Resources
	python editplist_for_url.py
