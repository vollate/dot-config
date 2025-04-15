1. Put the file in /etc/udev/hwdb.d
2. Run the command:
   `sudo systemd-hwdb update`
3. Run the command to trigger the udev rules update:
   `sudo udevadm trigger`

