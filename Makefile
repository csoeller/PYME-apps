PLATYPUS='/usr/local/bin/platypus'

all: VisGui.app	dh5view.app

VisGui.app: visgui.sh
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'VisGui' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  -y 'visgui.sh'

dh5view.app: dh5view.sh
	$(PLATYPUS) -D  -i '/Applications/Platypus.app/Contents/Resources/PlatypusDefault.icns'  -a 'dh5view' -o 'Progress Bar' -p '/bin/bash' -X '*' -T '****|fold'  -y 'dh5view.sh'
