#!/bin/bash
 set -e

 echo setting nodeJS repos
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash >/tmp/Cart.log

 echo installing NodeJS
 yum install nodejs -y>/tmp/Cart.log

echo adding user
 useradd roboshop>/tmp/Cart.log

echo downloding application content
 curl -s -L -o /tmp/Cart.zip "https://github.com/roboshop-devops-project/Cart/archive/main.zip">/tmp/Cart.log
 cd /home/roboshop>/tmp/Cart.log

echo extracting application archives
 recho removing files
 rm -rf Cart>/tmp/Cart.log
 unzip -o /tmp/Cart.zip>/tmp/Cart.log
 mv Cart-main Cart>/tmp/Cart.log
 cd Cart>/tmp/Cart.log

 echo installing NodeJS dependencies
 npm install>/tmp/Cart.log

echo configuring cart services
 mv /home/roboshop/Cart/systemd.service /etc/systemd/system/Cart.service>/tmp/Cart.log
 systemctl daemon-reload>/tmp/Cart.log

 echo starting cart service
 systemctl start Cart>/tmp/Cart.log
 systemctl enable Cart>/tmp/Cart.log