#! /bin/bash
echo -n Please input slack webook url:
read str

sudo sh -c "cat malware_monitor.sh | sed \"s!##webook_url##!${str}!\" > /usr/local/bin/malware_monitor"
sudo chmod 700 /usr/local/bin/malware_monitor
sudo chown root:wheel /usr/local/bin/malware_monitor
sudo cp malware_monitor_update.sh /usr/local/bin/malware_monitor_update
sudo chmod 700 /usr/local/bin/malware_monitor_update
sudo cp malware_monitor_wrapper /usr/local/bin/malware_monitor_wrapper
sudo chmod 700 /usr/local/bin/malware_monitor_wrapper
sudo chown root:wheel /usr/local/bin/malware_monitor_wrapper
cp freshclam.conf /usr/local/etc/clamav/freshclam.conf
cp clamd.conf /usr/local/etc/clamav/clamd.conf
mkdir /usr/local/etc/clamav/quarantine 2> /dev/null
mkdir /var/log/clamav/ 2> /dev/null
mkdir -p /usr/local/var/run/clamav 2> /dev/null
chown _clamav /var/log/clamav/
chown _clamav /usr/local/Cellar/clamav/*/share/clamav/
chown _clamav /usr/local/var/run/clamav
sudo install -m 644 ./jp.aeyesec.Clamd.plist /Library/LaunchDaemons
sudo launchctl unload /Library/LaunchDaemons/jp.aeyesec.Clamd.plist 2> /dev/null
sudo launchctl load /Library/LaunchDaemons/jp.aeyesec.Clamd.plist
sudo install -m 644 ./jp.aeyesec.ClamdOnAccessAlert.plist /Library/LaunchDaemons
sudo launchctl unload /Library/LaunchDaemons/jp.aeyesec.ClamdOnAccessAlert.plist 2> /dev/null
sudo launchctl load /Library/LaunchDaemons/jp.aeyesec.ClamdOnAccessAlert.plist
sudo install -m 644 ./jp.aeyesec.ClamdUpdate.plist /Library/LaunchDaemons
sudo launchctl unload /Library/LaunchDaemons/jp.aeyesec.ClamdUpdate.plist 2> /dev/null
sudo launchctl load /Library/LaunchDaemons/jp.aeyesec.ClamdUpdate.plist

