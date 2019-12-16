#!/usr/bin/env bash

echo
echo ">>>>> Script by wrobel.be <<<<<"
echo
echo "This script will flash your HackRF One to choosen software"
echo "To flash HackRF One, press the DFU button (the one closer to antenna),"
echo "keep it pressed and after pluging HackRF One release the button."
echo
read -n1 -r -p "Press any button to flash or close the terminal"

echo
echo "Updating the system"
echo
# pausing updating grub as it might triger ui
sudo apt-mark hold grub*
sudo apt update
sudo apt -y upgrade
echo
echo "Installing dependancies needed"
echo
sudo apt-get install dfu-util hackrf
echo
sleep 1s && dfu-util --device 1fc9:000c --download hackrf_one_usb.dfu --reset && sleep 5s && hackrf_spiflash -w "$1" && sleep 5s && hackrf_cpldjtag -x default.xsvf && sleep 1s
echo
# unpausing updating grub
sudo apt-mark unhold grub*
echo
echo "Done.... Please unplug the device and check if succeded."
