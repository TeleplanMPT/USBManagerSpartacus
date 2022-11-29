#!/bin/bash

cd
echo "Plug in the USB hub to be used: (you have 5 seconds)"
echo "(make sure that nothing is attached to the device)"
timeout -s SIGTERM 5s udevadm monitor --subsystem-match="usb" -k > add

USBstring=`more add | grep add | grep :1.0 | head -1`

#echo $USBstring

#regstr='([^*\/]+$)'

regstr='^.*[\/](.+?)\:'

[[ $USBstring =~ $regstr ]]

USBstring=${BASH_REMATCH[1]}

echo "What is the make of the hub?"
read hubmake

if [ $hubmake != "myhub" ]
then
  echo "hub not supported"
  end
fi

echo "how many ports are on the hub?"
read numports

echo "starting cell number"
read startcell
rm /etc/udev/rules.d/99-usb-serial.rules

if [ $numports = 10 ]
then
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.1:1.0\", SYMLINK+=\"Cell0\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.2:1.0\", SYMLINK+=\"Cell1\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.3:1.0\", SYMLINK+=\"Cell2\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.4:1.0\", SYMLINK+=\"Cell3\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.1:1.0\", SYMLINK+=\"Cell4\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.2:1.0\", SYMLINK+=\"Cell5\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.3:1.0\", SYMLINK+=\"Cell6\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.4:1.0\", SYMLINK+=\"Cell7\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.3:1.0\", SYMLINK+=\"Cell8\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.4:1.0\", SYMLINK+=\"Cell9\"" >>/etc/udev/rules.d/99-usb-serial.rules
elif [ $numports = 16 ]
then
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.1:1.0\", SYMLINK+=\"Cell0\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.2:1.0\", SYMLINK+=\"Cell1\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.3:1.0\", SYMLINK+=\"Cell2\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.2.4:1.0\", SYMLINK+=\"Cell3\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.3.1:1.0\", SYMLINK+=\"Cell4\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.3.2:1.0\", SYMLINK+=\"Cell5\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.3.3:1.0\", SYMLINK+=\"Cell6\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.3.4:1.0\", SYMLINK+=\"Cell7\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.4.1:1.0\", SYMLINK+=\"Cell8\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.4.2:1.0\", SYMLINK+=\"Cell9\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.4.3:1.0\", SYMLINK+=\"Cell10\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.4.4:1.0\", SYMLINK+=\"Cell11\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.1:1.0\", SYMLINK+=\"Cell12\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.2:1.0\", SYMLINK+=\"Cell13\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.3:1.0\", SYMLINK+=\"Cell14\"" >>/etc/udev/rules.d/99-usb-serial.rules
  echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j.1.4:1.0\", SYMLINK+=\"Cell15\"" >>/etc/udev/rules.d/99-usb-serial.rules
else
  i=$startcell
  j=1
  while [[ $i -lt $numports ]]; do
    echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j:1.0\", SYMLINK+=\"Cell$i\"" >>/etc/udev/rules.d/99-usb-serial.rules  
    ((i++))
    ((j++))
  done
fi


echo "SUBSYSTEM==\"tty\", KERNELS==\"$USBstring.$j:1.0\", SYMLINK+=\"Cell$i\"" >>/etc/udev/rules.d/99-usb-serial.rules

echo "Done!"
more /etc/udev/rules.d/99-usb-serial.rules
echo "Rules Created, please unplug and replug the USB into the same port"
