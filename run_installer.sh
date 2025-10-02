#!/bin/bash


# Usage: sudo ./run_installer.sh <img-filename> <hostname>
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  echo "Continuing anyway..."
fi

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: sudo $0 <img-filename> <hostname>"
  exit
fi

./sdm --customize $1 \
      --host $2 \
      --logwidth 132 \
      --regen-ssh-host-keys \
      --cscript sdm-customphase \
      --extend --xmb 11000 \
      --groups "sudo,video,adm,dialout,cdrom,audio,plugdev,games,users,input,render,netdev,spi,gpio,i2c,ssl-cert" \
      --plugin apps:"apps=ssl-cert|name=ssl-cert" \
      --plugin user:"deluser=pi" \
      --plugin user:"adduser=pi|password=hermes" \
      --plugin disables:"triggerhappy" \
      --plugin L10n:"timezone=America/Sao_Paulo|locale=en_US.UTF-8" \
      --batch
      #      --plugin system:"service-disable=apt-daily.timer,apt-daily-upgrade.timer" \
#      --plugin system:"expand-rootfs=onfirstboot" \
#      --plugin system:"ssh-enable=true" \
#      --plugin system:"ssh-passwordauth=true" \
#      --plugin system:"ssh-permitrootlogin=true" \

#      --restart

      #      --reboot 20
#       --apt-dist-upgrade \
#      --aptmaint update,upgrade,autoremove \
#     --plugin network:"netman=nm|wificountry=US|nmconn=/ssd/work/mywifi.nmconnection" \ # Use Network Manager and set up a connection
#     --plugin network:"netman=nm|ifname=wlan0|wificountry=US|wifissid=mySSID|wifipassword=myWifiPassword" \ # Set WiFi country, wifi SSID, and password for wlan0
#--plugin system:"systemd-config=timesync=/rpi/systemd/timesyncd.conf" \        # Configure systemd-timesyncd
#--plugin lxde:lhmouse \                                                        # If done against a desktop version, enable left-handed mouse
#--plugin L10n:host \                                                           # Get localization settings from the host
#--plugin bootconfig:"hdmi_force_hotplug=1|hdmi_ignore_edid|dtparam=sd_poll_once" \ # Add some settings to bootconfig
#--plugin apps:"apps=@/rpi/myapps|name=myapps" \                                     # Install apps from a list
#--plugin apps:"apps=@/rpi/myapps1|name=myapps2" \                                   # Install more apps
#--aptcache 192.168.42.4 \
    
     
