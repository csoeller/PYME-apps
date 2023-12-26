# Spotlight search jupyter notebooks

## References


1. [Github discussion how to get spotlight going on jupyer notebook files](https://github.com/jupyter/notebook/discussions/6862)
1. [Trouble shooting spotlight importers](https://developer.apple.com/library/archive/documentation/Carbon/Conceptual/MDImporters/Concepts/Troubleshooting.html)

## How to do it

Following the discussion in [1], I copied `/System/Library/Spotlight/RichText.mdimporter` to `/Library/Spotlight` and renamed it as `Jupyter.mdimporter`.

As suggested, I edited `Contents/Info.plist` therein. Contrary do what is shown in [1], I could not get it to work straight away.

`/usr/bin/mdimport -L` lists all currently known importers but even after `/usr/bin/mdimport -r InstallDirectory/YourPlug-In` (in our case residing at `/Library/Spotlight/Jupyter.mdimporter`) our mdimporter was not listed.

I then tried the toubleshooting guidelines in [2] and edited Info.plist further. The eventual diff to the Info.plist from `RichText.mdimporter` is listed at the bottom of this file.

In particular, I edited the UUID, according to the hint in [2]:

   ```you should check that...the UUID that you created for your importer is unique```

I also changed to dynamic registration (set to true). In addition, I changed ownership to root.wheel.

Hard to say which one is the critical change, in any case, the jupyter mdimporter eventually showed up in a `mdimport -L` call:

    ...
    "/System/Library/Spotlight/CoreMedia.mdimporter",
    "/Library/Spotlight/Jupyter.mdimporter",
    "/Library/Spotlight/iBooksAuthor.mdimporter",
    ...

And indeed, searches for strings in the python code in `.ipynb` files now turn up the expected results.

### Info.plist diff

```diff
--- /System/Library/Spotlight/RichText.mdimporter/Contents/Info.plist	2023-12-02 04:55:20.000000000 +0100
+++ /Users/csoe002/Desktop/Info.plist	2023-12-25 11:04:51.000000000 +0100
@@ -13,14 +13,7 @@
 			<string>MDImporter</string>
 			<key>LSItemContentTypes</key>
 			<array>
-				<string>public.rtf</string>
-				<string>public.html</string>
-				<string>public.xml</string>
-				<string>public.plain-text</string>
-				<string>com.apple.traditional-mac-plain-text</string>
-				<string>com.apple.rtfd</string>
-				<string>com.apple.webarchive</string>
-				<string>org.oasis-open.opendocument.text</string>
+				<string>org.jupyter.ipynb</string>
 			</array>
 		</dict>
 	</array>
@@ -33,7 +26,7 @@
 	<key>CFBundleInfoDictionaryVersion</key>
 	<string>6.0</string>
 	<key>CFBundleName</key>
-	<string>Rich Text Sniffer</string>
+	<string>Jupyter ipynb Sniffer</string>
 	<key>CFBundleShortVersionString</key>
 	<string>6.9</string>
 	<key>CFBundleSupportedPlatforms</key>
@@ -45,17 +38,17 @@
 	<key>CFPlugInDynamicRegisterFunction</key>
 	<string></string>
 	<key>CFPlugInDynamicRegistration</key>
-	<false/>
+	<true/>
 	<key>CFPlugInFactories</key>
 	<dict>
-		<key>502B7F32-60DD-11D8-87A4-000393CC3466</key>
+		<key>502B7F32-60DD-11D8-87A4-000393CC3588</key>
 		<string>RichTextSnifferPluginFactory</string>
 	</dict>
 	<key>CFPlugInTypes</key>
 	<dict>
 		<key>8B08C4BF-415B-11D8-B3F9-0003936726FC</key>
 		<array>
-			<string>502B7F32-60DD-11D8-87A4-000393CC3466</string>
+			<string>502B7F32-60DD-11D8-87A4-000393CC3588</string>
 		</array>
 	</dict>
 	<key>CFPlugInUnloadFunction</key>
```