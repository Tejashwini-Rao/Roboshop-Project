#!/bin/bash
source Common.sh
component=cart

 NodeJS

  echo configuring cart services
  mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service&>>/tmp/cart.log
  systemctl daemon-reload&>>/tmp/cart.log
  systemctl start cart&>>/tmp/cart.log
  systemctl enable cart&>>/tmp/cart.log
  StatusCheck


