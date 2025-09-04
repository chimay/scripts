jls
sudo jail start ubuntu
sudo jexec ubuntu /bin/bash
sudo jexec ubuntu /bin/bash -c "su -c /opt/google/chrome/chrome-wrapper - hsebert"
sudo service jail onestart ubuntu
sudo sysrc jail_enable="YES"
