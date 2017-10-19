#!/usr/bin/env bash

####
# ADB - List All Device Architectures
# author: Tim Reynolds : http://timreynolds.org
####

echo "\n\nList Device Architectures...\n\n"

# get full path to adb just in case script gets confused
ADBPATH="${ANDROID_HOME}/platform-tools"

for SERIAL in $(adb devices | tail -n +2 | cut -sf 1);
   do
     
     echo "*********************************** "
     echo "   Device Serial Number -> $SERIAL Architecture *****";
     echo "*********************************** "

     adb -s $SERIAL shell getprop | grep -e manufacturer -e model -e abi
     echo "\n**** END $SERIAL ****";
     echo "\r\n";
   done

echo "***** End List Device Architectures *****"
