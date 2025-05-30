#!/bin/bash
# A script that gets the current device's information via ADB
device=$1

echo "Complete Software build for device.: $device"
sw_build=`adb -s $device shell getprop ro.build.description`
printf 'Complete software build  : %s\n' "$sw_build"
echo ""

echo "Device information...."
serialNo=`adb -s $device shell getprop ro.serialno`
printf 'Serial No   : %s\n' "$serialNo"

build_id=`adb -s $device shell getprop ro.build.id`
printf 'build id    : %s\n' "$build_id"

build_type=`adb -s $device shell getprop ro.build.type`
printf 'build type  : %s\n' "$build_type"

build_tags=`adb -s $device shell getprop ro.build.tags`
printf 'build tags  : %s\n' "$build_tags"

build_state=`adb -s $device shell getprop ro.boot.vbmeta.device_state`
printf 'build state : %s\n' "$build_state"

build_date=`adb -s $device shell getprop ro.product.build.date`
printf 'product build date : %s\n' "$build_date"


#output to file $device
printf 'Complete software build: %s\n\nSerial No   : %s\nbuild id    : %14s\nbuild type  : %s\nbuild tags  : %s\nbuild state : %s\nbuild date  : %s\n' "$sw_build" "$serialNo" "$build_id" "$build_type" "$build_tags" "$build_state" "$build_date" > $device.txt


echo "###### Done serial: $device ######"