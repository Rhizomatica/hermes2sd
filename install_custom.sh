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
      --cscript custom_setup.sh \
      --extend --xmb 11000 \
      --plugin user:"deluser=pi" \
      --plugin user:"adduser=pi|password=hermes" \
      --groups "sudo,video,adm,dialout,cdrom,audio,plugdev,games,users,input,render,netdev,spi,gpio,i2c,ssl-cert" \
      --plugin apps:"apps=ssl-cert|name=ssl-cert" \
      --plugin disables:"triggerhappy" \
      --plugin L10n:"timezone=America/Sao_Paulo|locale=en_US.UTF-8"