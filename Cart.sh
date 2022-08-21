#!/bin/bash


 echo setting nodeJS repos
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash >/tmp/Cart.log
 echo $?

 echo installing NodeJS
 yum install nodejs -y>/tmp/Cart.log
 echo $?

 echo adding user
 useradd roboshop>/tmp/Cart.log
 echo $?

 echo downloding application content
 curl -s -L -o /tmp/Cart.zip "https://github.com/roboshop-devops-project/Cart/archive/main.zip">/tmp/Cart.log
 cd /home/roboshop>/tmp/Cart.log
 echo $?

 echo cleaning old application
 rm -rf Cart>/tmp/Cart.log
 echo $?

echo extracting application archives
 unzip -o /tmp/Cart.zip>/tmp/Cart.log
 mv Cart-main Cart>/tmp/Cart.log
 cd Cart>/tmp/Cart.log
 echo $?

 echo installing NodeJS dependencies
 npm install>/tmp/Cart.log
 echo $?

  echo configuring cart services
  mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
  systemctl daemon-reload
  systemctl start cart
  systemctl enable cart
  echo $?


