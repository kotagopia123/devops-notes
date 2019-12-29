Time Synchronize Issue with AWS accounts in Ansible:
----------------------------------------------------
sudo date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"