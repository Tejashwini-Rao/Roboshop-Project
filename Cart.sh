#!/bin/bash
 set -e
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash >/tmp/Cart.log
 yum install nodejs -y>/tmp/Cart.log

 useradd roboshop>/tmp/Cart.log

 curl -s -L -o /tmp/Cart.zip "https://github.com/roboshop-devops-project/Cart/archive/main.zip">/tmp/Cart.log
 cd /home/roboshop>/tmp/Cart.log
 rm -rf Cart>/tmp/Cart.log
 unzip -o /tmp/Cart.zip>/tmp/Cart.log
 mv Cart-main Cart>/tmp/Cart.log
 cd Cart>/tmp/Cart.log
 npm install>/tmp/Cart.log

 mv /home/roboshop/Cart/systemd.service /etc/systemd/system/Cart.service>/tmp/Cart.log
 systemctl daemon-reload>/tmp/Cart.log
 systemctl start Cart>/tmp/Cart.log
 systemctl enable Cart>/tmp/Cart.log