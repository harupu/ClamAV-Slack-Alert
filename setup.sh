#! /bin/bash
echo -n Please input slack webook url:
read str
sudo mkdir -p /opt/local/share/clamav/
sudo sh -c "cat clam_monitor.sh | sed \"s!##webook_url##!${str}!\" > /opt/local/share/clamav/clam_monitor.sh"
sudo chmod 755 /opt/local/share/clamav/clam_monitor.sh
sudo install -m 644 ./com.example.ClamdAlert.plist /Library/LaunchDaemons
sudo launchctl unload /Library/LaunchDaemons/com.example.ClamdAlert.plist 2> /dev/null
sudo launchctl load /Library/LaunchDaemons/com.example.ClamdAlert.plist
