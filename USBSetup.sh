#!/bin/bash

cd

timeout -s SIGTERM 5s udevadm monitor --subsystem-match="usb" -k > add

USBstring=`more add | grep add | grep :1.0 | head -1`

#echo $USBstring

#regstr='([^*\/]+$)'

regstr='^.*[\/](.+?)\:'

[[ $USBstring =~ $regstr ]]

USBstring=${BASH_REMATCH[1]}

echo "how many ports?"
read numports

echo "starting port"
read startport
rm /etc/udev/rules.d/99-usb-serial.rules

i=0
j=1
while [[ $i -lt $numports ]]; do
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j:1.0\", SYMLINK+=\"Cell$i\"" >>/etc/udev/rules.d/99-usb-serial.rules
  ((i++))
  ((j++))
done
echo "Done!"
more /etc/udev/rules.d/99-usb-serial.rules
