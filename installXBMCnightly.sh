#!/bin/sh
device=$1
if [ $device ]; then
	file=`python2 downloadXBMCnightly.py`
	adb -r -s $device install $file
fi