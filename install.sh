#!/bin/bash

# Force Google DNS for install
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf

# Set the glint-nes branch to pull from on github if it isn't already set
if [ -z "$GLINTNESBRANCH" ]
then
  export GLINTNESBRANCH=master
fi

# Pull down component scripts
curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/clean-pi.sh > $HOME/clean-pi.sh
curl -L https://raw.github.com/normalocity/glint-nes/$GLINTNESBRANCH/scripts/glint-nes.sh > $HOME/glint-nes.sh

# Run scripts
cd $HOME
bash clean-pi.sh
bash glint-nes.sh

# Remove scripts
rm $HOME/clean-pi.sh
rm $HOME/glint-nes.sh

# Clear history
history -c
rm $HOME/.bash_history

# Clean up packages
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo apt-get -y clean

# Purge log files
sudo rm -rf `find /var/log/ . -type f`

# Reboot
echo "\n\nRebooting...\n"
sudo shutdown -r now