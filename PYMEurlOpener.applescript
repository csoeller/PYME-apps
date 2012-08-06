on open location this_URL
	set theCommand to POSIX path of (path to resource "pyme-urlopen.sh")
	do shell script "/bin/bash " & theCommand & " '" & this_URL & "'"
end open location
