import pyudev
import os, os.path
import time

context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)
total_cells = 0
cell_count = 0
if os.path.exists("/etc/udev/rules.d/99-usb-serial.rules"):
    os.remove("/etc/udev/rules.d/99-usb-serial.rules")

while True:
    try:
        total_cells = int(input("Enter the number of cells:"))
        total_cells = total_cells-1
    except:
        print ("Try Again...")
    else:
        break

print('Plug the cells in, in order, starting at cell 0:')
f = open("/etc/udev/rules.d/99-usb-serial.rules", "a")

for device in iter(monitor.poll, None):
    if cell_count > total_cells:
        break
    if device.subsystem == 'usb':
        if device.action == 'bind':
            if device.device_type == 'usb_interface':
                if device.driver != 'hub':
                    path = device.device_path.split("/")[-1]
                    f.write('SUBSYSTEM==\"tty\", KERNELS==\"%s", SYMLINK+=\"Cell%s\"' % (path, cell_count))
                    f.write('\n')
                    #print('SUBSYSTEM==\"tty\", KERNELS==\"%s", SYMLINK+=\"Cell%s\"' % (path, cell_count))
                    print('Found cell %s ' %(cell_count))
                    cell_count += 1

f.close()
print('New Rules!')
os.system('more /etc/udev/rules.d/99-usb-serial.rules')
print('\n')
time.sleep(1)
os.system('udevadm control --reload-rules && udevadm trigger')
print('\n')
time.sleep(1)
print('Loaded Cells!')
os.system('ls /dev/ | grep Cell')
#>>/etc/udev/rules.d/99-usb-serial.rules
