import plistlib

relativePlistPath = 'PYMEurlOpener.app/Contents/Info.plist'
info = plistlib.Plist.fromFile(relativePlistPath)

# add the entries to handle our custom url
info["CFBundleIdentifier"] = "com.pyme.AppleScript.pyme"
theEntry = {}
theEntry["CFBundleURLName"] = "Pyme"
theEntry["CFBundleURLSchemes"] = ["pyme"]
info["CFBundleURLTypes"] = []
info["CFBundleURLTypes"].append(theEntry)

info.write(relativePlistPath)
