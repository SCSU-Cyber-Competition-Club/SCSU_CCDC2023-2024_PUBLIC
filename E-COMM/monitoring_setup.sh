#Setting up monitoring script
sudo cp monitoring.sh /usr/local/sbin/security_monitoring
sudo chmod 700 /usr/local/sbin/security_monitoring
sudo touch /var/log/security_monitoring.log
sudo touch /var/log/last_check_time
sudo touch /var/log/previous_events.hash
sudo touch /var/log/suid_files.list
sudo chmod 640 /var/log/security_monitoring.log
sudo chmod 640 /var/log/last_check_time
sudo chmod 640 /var/log/previous_events.hash
sudo chmod 640 /var/log/suid_files.list

# Add sudoers entry for notify-send (safely using echo and tee)
echo "root ALL=(ALL) NOPASSWD: /usr/bin/notify-send" | sudo EDITOR='tee -a' visudo

#Adding monitoring script to crontab
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/local/sbin/security_monitoring") | crontab -
