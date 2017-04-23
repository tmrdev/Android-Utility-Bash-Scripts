#!/usr/bin/env bash

echo "List Device Architectures..."

# get full path to adb just in case script gets confused
ADBPATH="${ANDROID_HOME}/platform-tools"

for SERIAL in $(adb devices | tail -n +2 | cut -sf 1);
   do
     echo "**** Device Serial Number -> $SERIAL Architecture *****";
     adb -s $SERIAL shell getprop | grep -e manufacturer -e model -e abi
     echo "**** END $SERIAL ****";
     echo "\r\n";
   done

echo "***** End List Device Architectures *****"
