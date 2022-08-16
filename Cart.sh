#!/bin/bash
 set -e
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash >/tmp/Cart.log
 yum install nodejs -y>/temp/Cart.log

 useradd roboshop>/temp/Cart.log

 curl -s -L -o /tmp/Cart.zip "https://github.com/roboshop-devops-project/Cart/archive/main.zip">/temp/Cart.log
 cd /home/roboshop>/temp/Cart.log
 rm -rf Cart>/temp/Cart.log
 unzip -o /tmp/Cart.zip>/temp/Cart.log
 mv Cart-main Cart>/temp/Cart.log
 cd Cart>/temp/Cart.log
 npm install>/temp/Cart.log

 mv /home/roboshop/Cart/systemd.service /etc/systemd/system/Cart.service>/temp/Cart.log
 systemctl daemon-reload>/temp/Cart.log
 systemctl start Cart>/temp/Cart.log
 systemctl enable Cart>/temp/Cart.log