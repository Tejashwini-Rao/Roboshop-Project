#!/bin/bash


 echo setting nodeJS repos
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
 if [ $? -eq 0 ]
 then
   echo -e "\e[32mSUCCESS\e[0m"
 else
   echo -e "\e[31mFAILURE\e[0m"
   exit
 fi

 echo installing NodeJS
 yum install nodejs -y&>>/tmp/cart.log

 if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi

 id roboshop&>>/tmp/cart.log
 if [ $? -ne 0]
 then
   echo adding user
   useradd roboshop&>>/tmp/cart.log

   if [ $? -eq 0 ];
    then
      echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31mFAILURE\e[0m"
      exit
    fi
  fi

 echo downloding application content
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"&>>/tmp/cart.log
 cd /home/roboshop&>>/tmp/cart.log

 if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
 echo cleaning old application
 rm -rf cart&>>/tmp/cart.log

 if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
echo extracting application archives
 unzip -o /tmp/cart.zip&>>/tmp/cart.log
 mv cart-main cart&>>/tmp/cart.log
 cd cart&>>/tmp/cart.log

 if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
 echo installing NodeJS dependencies
 npm install&>>/tmp/cart.log
 if [ $? -eq 0 ]
  then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit
  fi
  echo configuring cart services
  mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service&>>/tmp/cart.log
  systemctl daemon-reload&>>/tmp/cart.log
  systemctl start cart&>>/tmp/cart.log
  systemctl enable cart&>>/tmp/cart.log
  if [ $? -eq 0 ]
    then
      echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31mFAILURE\e[0m"
      exit
    fi

  if [ $? -eq 0 ]
   then
     echo -e "\e[32mSUCCESS\e[0m"
   else
     -e "\e[31mFAILURE\e[0m"
   fi

