#!/bin/sh
clear;
echo 'Enter name of apk you want to convert:';
read file;
apktool d -f $file;
filename=$(basename $file)
outFolder=${filename%.*};
if [ -d $outFolder ]; then
	echo 'Converting apk to OUYA game...';
	xmlFile=$outFolder'/AndroidManifest.xml';
	contents=`cat $xmlFile`;
	newContents=`awk '/android.intent.category.LAUNCHER/{print "<category android:name=\"tv.ouya.intent.category.GAME\"/>"}1' $xmlFile`
	rm $xmlFile;
	touch $xmlFile;
	echo $newContents >> $xmlFile;
	echo 'Contents of AndroidManifest.xml replaced.';
	echo 'Now building the new apk...';
	apktool b $outFolder $file
	echo 'Enter android as passphrase.';
	jarsigner -verbose -keystore $HOME'/.android/debug.keystore' $file androiddebugkey
fi
