#!/bin/bash
wget -O /tmp/fake-ubuntu-advantage-tools.deb "https://github.com/Skyedra/UnspamifyUbuntu/blob/master/fake-ubuntu-advantage-tools/fake-ubuntu-advantage-tools.deb?raw=true"
apt-get install /tmp/fake-ubuntu-advantage-tools.deb -y
sudo apt autoremove -y
sudo sed -Ezi.orig -e 's/(def _output_esm_service_status.outstream, have_esm_service, service_type.:\n)/\1    return\n/' -e 's/(def _output_esm_package_alert.*?\n.*?\n.:\n)/\1    return\n/' /usr/lib/update-notifier/apt_check.py
sudo /usr/lib/update-notifier/update-motd-updates-available --force
sudo sed -i 's/^ENABLED=.*/ENABLED=0/' /etc/default/motd-news
sudo rm -rf /var/lib/ubuntu-advantage/messages/motd-esm-announce
sudo mv /etc/apt/apt.conf.d/20apt-esm-hook.conf /etc/apt/apt.conf.d/20apt-esm-hook.conf.disabled
