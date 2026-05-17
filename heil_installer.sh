#!/bin/bash

#colors
BLACK_COLOR="\e[30m"
RED_COLOR="\e[31m"
GREEN_COLOR="\e[32m"
YELLOW_COLOR="\e[33m"
BLUE_COLOR="\e[34m"
MAGENTA_COLOR="\e[35m"
CYAN_COLOR="\e[36m"
GRAY_COLOR="\e[90m"
WHITE_COLOR="\e[97m"
RESET_COLOR="\e[0m"

#clear screen
#clear

#logo
echo -e "${RED_COLOR}
    ██   ██ ███████  ██  ██      
    ██   ██ ██       ██  ██      
    ███████ █████    ██  ██      
    ██   ██ ██       ██  ██      
    ██   ██ ███████  ██  ███████                        
    Hijack•Exploit•Inject•Lure                                     
${RESET_COLOR}"

echo -e "Use SSH to run this tool"
echo -e "Installing TFT Display 3.5 Drivers"
read -p "[select] Option > SPI . enable [press enter to continue, ctrl +x to quit]" 

#raspi config
#sudo raspi-config

#update and upgrade
echo -e "Updating System"
sudo apt update
echo -e "Upgrading System"
sudo apt upgrade
echo -e "Installing Git"
sudo apt install git

#extract display driver
echo -e "Extracting display driver"
tar -xzvf lcd_driver.tar.gz

#get into driver folder
cd LCD-show/

#add execute permission
sudo chmod +x LCD35-show 

#running
sudo ./LCD35-show 
echo -e "LCD Set [changes will be visible after Reboot]"

#enable display for console
echo -e "Enable display for console"
echo "fbcon=map:10 fbcon=font:VGA8x8 fbcon=rotate:1" >> /boot/firmware/cmdline.txt
echo "display_rotate=1" >> /boot/firmware/config.txt

#portrait display
echo -e " Making display portrait"
echo "display_rotate=1" >> /boot/firmware/config.txt

#fix keyboard mismapping issue
echo -e "Fixing keyboard mismapping"
sudo cp keyboard /etc/default/keyboard 

#setting up the gpio keys
echo -e "Setting GPIO Keys"
echo -e '

dtoverlay=gpio-key,gpio=26,keycode=103,label="UP"
dtoverlay=gpio-key,gpio=21,keycode=108,label="DOWN"
dtoverlay=gpio-key,gpio=20,keycode=28,label="ENTER"

dtoverlay=gpio-key,gpio=19,keycode=6,label="5"
dtoverlay=gpio-key,gpio=16,keycode=29,label="CTRL"

dtoverlay=gpio-key,gpio=13,keycode=46,label="C"
dtoverlay=gpio-key,gpio=12,keycode=38,label="L"
' >>  /boot/firmware/config.txt

echo -e "

Connection (JOYSTICK)

Joystick   Raspberry pi 4b
---------------------------
COM      -  GND
UP       - GPIO 26 (UP)
DWN      - GPIO 21 (DOWN)
MID      - GPIO 20 (Enter)
RHT      - GPIO 13 (key C)
LFT      - GPIO 12 (key L)
SET      - GPIO 19 (key 5)
RST      - GPIO 16 (key CTRL)

"

reboot



