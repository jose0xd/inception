# How to set up your environment in your vm? #

### Edit /etc/hosts to add your server name to the list of host accepted ###

127.0.0.1 login.42.fr

### Create a new user named after your login and assign it to the different groups ###

`sudo adduser login`

`sudo usermod -aG sudo login`

`sudo usermod -aG docker login`

`sudo usermod -aG vboxsf login (if you use shared folders on your vm)`

### Get the latest version of docker-compose to be able to use docker-compose with a makefile ###

* Delete previous version

`sudo apt-get remove docker-compose`

`sudo rm -f /usr/local/bin/docker-compose`

* Install newest version

`sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Darwin-x86_64" -o /usr/local/bin/docker-compose
(version 29.2 at the time of this readme)`

`sudo chmod +x /usr/local/bin/docker-compose`

### Stop the nginx and mysql service which are set by default on 42 vm ###

`sudo service nginx stop`

`sudo service mysql stop`

### If you get the following error message : Docker compose up : error while fetching server API version ###

`sudo gpasswd -a $USER docker`

`newgrp docker`
