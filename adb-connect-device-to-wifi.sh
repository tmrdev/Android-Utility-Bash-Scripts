#!/usr/bin/env bash

####
# ADB - Connect Device Through Wifi
# author: Tim Reynolds : http://timreynolds.org
#
# Try connecting only one device at a time through usb when using this script.  Multiple devices can be connected one by one
#
####

echo "\r\nList it foo...\r\n"

# get full path to adb just in case script gets confused 
ADBPATH="${ANDROID_HOME}/platform-tools"
WIFI_PORT=5555
# This current code only connects one device at a time through wifi for adb 
# Need to see if it is possible to connect more then one device

for SERIAL in $(adb devices | tail -n +2 | cut -sf 1); 
   do  

      echo "   *********************************** "
      echo "   Device Serial #: -> $SERIAL "
      echo "   *********************************** "

      adb -s $SERIAL shell ip route > device-ip-info.txt
      ip_addrs=$(awk {'if( NF >=9){print $9;}'} device-ip-info.txt)

      echo "\n"    
      echo "   *********************************** "
      echo "   The device ip address is $ip_addrs " 
      echo "   *********************************** "
      echo "\n"

      if [[ -n "${ip_addrs/[ ]*\n/}" ]]
      then

        echo "\n"
        echo "   *********************************** "
        echo "   Found Ip Address -> $ip_addrs "
        echo "   *********************************** "
        echo "\n"

        adb -s $SERIAL tcpip 5555 
        # adb connect $ip_addrs:5555
        #adb connect $ip_addrs:5555

        echo "\n\n"
        echo "   *********************************** "
        echo "   starting up adb wifi connection on port 5555 ";
        echo "   *********************************** "

        sleep 6
            
        echo "\n\n"

        read -p "Remove USB connection from device and the device will try to connect through wifi. Press any key to continue... " -n1 -s  

        echo ""
        echo ""
            
        echo "*********************************** "
        adb connect $ip_addrs
        echo "*********************************** "

        echo ""
        echo ""

        sleep 3

        adb devices

        sleep 3

        echo "*********************************** "
        echo "Your device should be listed above with the assigned wifi ip address"
        echo "*********************************** "

        echo "\n\n"
        adb connect $ip_addrs:5555

        exit

       else
        echo "*********************************** "
        echo "Did Not Find Ip Address. Check network connectivity. -> $ip_addrs"
        echo "*********************************** "
       fi

   done

echo "\r\n";

echo "\r\n**** foo has left the building *****\r\n"


