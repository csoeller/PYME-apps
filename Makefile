PLATYPUS='/usr/local/bin/platypus'

all: VisGui.app	dh5view.app

VisGui.app:
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'VisGui' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  'visgui.sh'

dh5view.app:
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'dh5view' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  'dh5view.sh'
