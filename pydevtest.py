import pyudev
import os
import time
import usb.core


context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)


#for device in context.list_devices(subsystem='usb'):

for device in iter(monitor.poll, None):
    print(device.action, device.device_type, device)
    dev = usb.core.find()

