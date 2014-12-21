#!/usr/bin/env bash

#Set Timezone
cp /usr/share/zoneinfo/America/Denver /etc/localtime

#Bring box up to date
apt-get update

#Add repositories
apt-get install -y python-software-properties
add-apt-repository ppa:git-core/ppa

#Bring box up to date again (force PPAs to update)
apt-get update

#Install Vim
apt-get install -y vim

#Install htop
apt-get install -y htop

#Install Git
apt-get install -y git

#Install pip
apt-get install -y python-pip

#Pip installs
pip install requests

#Install NodeJS
apt-get install -y nodejs

#Install Sqlite3
apt-get install -y sqlite3

#Install PHP
apt-get install -y php5

#Install Apache
apt-get install -y apache2
if ! [ -L /var/www ]; then
    rm -rf /var/www
    ln -fs /vagrant /var/www
fi

#Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password MySuperPassword'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MySuperPassword'
apt-get install -y mysql-server

cd /vagrant/
vagrantR="VagrantResults.log"
> $vagrantR
date >> $vagrantR
gitVer=$(git --version)
echo "git Version: $gitVer" >> $vagrantR
vimVer=$(vim --version | head -1 )
echo "vim Version: $vimVer" >> $vagrantR
nodeVer=$(node --version)
echo "node Version: $nodeVer" >> $vagrantR
phpVer=$(php -v | head -1 )
echo "php Version: $phpVer" >> $vagrantR
sqlite3Ver=$(sqlite3 -version)
echo "sqlite3 Version: $sqlite3Ver" >> $vagrantR
apache2Ver=$(apache2 -v | head -1)
echo "apache2 Version: $apache2Ver" >> $vagrantR
mysqlVer=$(mysql -h localhost -V )
echo "mysql Version: $mysqlVer" >> $vagrantR
