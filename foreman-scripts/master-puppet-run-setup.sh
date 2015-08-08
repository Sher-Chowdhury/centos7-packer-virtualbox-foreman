#!/bin/bash
# http://offandon.org/2015/07/foreman-1-8-and-puppet-run/
# https://groups.google.com/forum/#!topic/foreman-users/Hc9jpn0ljEc

  
hammer settings set --name puppetrun --value true

# Create and configure .ssh folder for the "foreman-proxy" user 
mkdir /usr/share/foreman-proxy/.ssh
chmod 700 /usr/share/foreman-proxy/.ssh/
chown foreman-proxy:foreman-proxy /usr/share/foreman-proxy/.ssh

# Copy in the files to the .ssh folder
cp /vagrant/foreman-scripts/rsa-public-and-private-keys/* /usr/share/foreman-proxy/.ssh
chmod 600 /usr/share/foreman-proxy/.ssh/id_rsa
chmod 644 /usr/share/foreman-proxy/.ssh/id_rsa.pub

# cp /vagrant/foreman-scripts/rsa-public-and-private-keys/id_rsa /etc/foreman-proxy/id_rsa
# chmod 600 /etc/foreman-proxy/id_rsa
# chown foreman-proxy:foreman-proxy /etc/foreman-proxy/id_rsa

echo "
Host *
    StrictHostKeyChecking no
" > /usr/share/foreman-proxy/.ssh/config    

chown foreman-proxy:foreman-proxy /usr/share/foreman-proxy/.ssh/*


sed -i -e 's/#:puppet_provider: puppetrun/:puppet_provider: puppetssh/g' /etc/foreman-proxy/settings.d/puppet.yml
sed -i -e 's+#:puppetssh_keyfile: /etc/foreman-proxy/id_rsa+:/usr/share/foreman-proxy/.ssh+g' /etc/foreman-proxy/settings.d/puppet.yml
sed -i -e 's/#:puppet_user: root/:puppet_user: root/g' /etc/foreman-proxy/settings.d/puppet.yml


exit 0




# manually perform ssh connections and connect using all agent machine aliases, i.e. hostname, ip-number, fqdn,
# this is to ensure all RSA fingerprinting is completed. or maybe this will work:




exit 0