#!/bin/bash


 echo setting nodeJS repos
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>&>>/tmp/cart.log
 echo $?

 echo installing NodeJS
 yum install nodejs -y&>>/tmp/cart.log
 echo $?

 echo adding user
 useradd roboshop&>>/tmp/cart.log
 echo $?

 echo downloding application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"&>>/tmp/cart.log
 cd /home/roboshop&>&>>/tmp/cart.log
 echo $?

 echo cleaning old application
 rm -rf cart&>>/tmp/cart.log
 echo $?

echo extracting application archives
 unzip -o /tmp/cart.zip&>>/tmp/cart.log
 mv cart-main cart&>>/tmp/cart.log
 cd cart&>>/tmp/cart.log
 echo $?

 echo installing NodeJS dependencies
 npm install&>>/tmp/cart.log
 echo $?

  echo configuring cart services
  mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
  systemctl daemon-reload
  systemctl start cart
  systemctl enable cart
  echo $?


