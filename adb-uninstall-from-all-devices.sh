#!/usr/bin/env bash

####
# ADB - Uninstall From All Devices
# author: Tim Reynolds : http://timreynolds.org
####

echo "\n\nUninstall foo...\n\n"

# get full path to adb just in case script gets confused
ADBPATH="${ANDROID_HOME}/platform-tools"
GREP_PACKAGE=""
MYPACKAGE="com.globieapp.globie"

for SERIAL in $(adb devices | tail -n +2 | cut -sf 1);
   do
    # only try uninstalling if the package exists
    GREP_PACKAGE=$($ADBPATH/adb -s $SERIAL shell pm list packages | grep $MYPACKAGE 2> /dev/null)

    echo "\n\n*********************************** "
    echo "Can we find the package? :: grepped result ---> $GREP_PACKAGE"
    echo "*********************************** "

    if [[ -n "${GREP_PACKAGE/[ ]*\n/}" ]]
      then

        echo "\n\n*********************************** "
        echo "Found Package To Uninstall On -> $SERIAL";
        echo "*********************************** "

        echo "\n\n"
        echo "Will attempt uninstall on $SERIAL\n\n";
        $ADBPATH/adb -s $SERIAL uninstall $MYPACKAGE
      else
        echo "*********************************** "
        echo "Package Not Found On -> $SERIAL"
        echo "*********************************** "
      fi
   done
echo "\n\n***** Uninstall has left the building *****"

