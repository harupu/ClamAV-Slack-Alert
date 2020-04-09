# ClamAV-Slcak-Alert
Alert ClamAV detection events to slack

## install

1. install homebrew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update
```

2. install clamav and fswatch

```
brew install clamav
brew install fswatch
```

3. Run setup.sh:
```
$ chmod 755 setup.sh
$ sudo ./setup.sh
Password: [input password for sudo]
Please input slack webook url:https://hooks.slack.com/services/xxxx (Your webook url)
```

4. Allow FullDiskAccess to malware_monitor_wrapper

To find /usr/local/bin/ on dialog, type Command+Shift+G.

<img src="https://user-images.githubusercontent.com/7601382/78830555-1c921080-7a23-11ea-85c6-fabcc0e6c21c.png" width=400>

5. Update and reload
```
$ freshclam -v
$ /usr/local/bin/clamdscan --reload
```

6. Download eicar.com and check it works or not.
