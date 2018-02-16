#! /usr/bin/env sh

THEME='grub-theme-razer'

echo 'Fetching theme archive'
wget https://github.com/s3w47m88/grub-theme-razer/archive/master.zip
echo ''
echo 'Unpacking theme'
unzip master.zip
echo ''
echo 'Creating GRUB themes directory'
sudo mkdir -p /boot/grub/themes/$THEME
echo ''
echo 'Copying theme to GRUB themes directory'
sudo cp -r $THEME-master/* /boot/grub/themes/$THEME
echo ''
echo 'Removing other themes from GRUB config'
sudo sed -i '/^GRUB_THEME=/d' /etc/default/grub
echo ''
echo 'Removing empty lines at the end of GRUB config' # optional
sudo sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' /etc/default/grub
echo ''
echo 'Adding new line to GRUB config just in case' # optional
echo | sudo tee -a /etc/default/grub
echo ''
echo 'Adding theme to GRUB config'
echo "GRUB_THEME=/boot/grub/themes/$THEME/theme.txt" | sudo tee -a /etc/default/grub
echo ''
echo 'Updating GRUB'
sudo update-grub
echo ''
echo 'Removing theme installation files'
rm -rf master.zip $THEME-master
echo ''
echo 'The installation script has completed. You should be able to restart your computer and see the new GRUB theme.'