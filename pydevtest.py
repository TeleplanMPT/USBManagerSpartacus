import pyudev
import os
import time
import usb.core


context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)

dev = usb.core.find(find_all=True, idVendor=0x05e3)
if dev is None:
    print('Device not found')
for cfg in dev:
    print(cfg.bDeviceClass)
#print(dev)
#for device in context.list_devices(subsystem='usb'):

for device in iter(monitor.poll, None):
    print(device.device_number)
   
