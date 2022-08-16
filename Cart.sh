#!/bin/bash
 set -e
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash >/temp/cart.log
 yum install nodejs -y>/temp/cart.log

 useradd roboshop>/temp/cart.log

 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip">/temp/cart.log
 cd /home/roboshop>/temp/cart.log
 rm -rf cart>/temp/cart.log
 unzip -o /tmp/cart.zip>/temp/cart.log
 mv cart-main cart>/temp/cart.log
 cd cart>/temp/cart.log
 npm install>/temp/cart.log

 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service>/temp/cart.log
 systemctl daemon-reload>/temp/cart.log
 systemctl start cart>/temp/cart.log
 systemctl enable cart>/temp/cart.log