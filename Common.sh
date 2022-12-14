StatusCheck(){
  if [ $? -eq 0 ]
    then
      echo -e "\e[32mSUCCESS\e[0m"
    else
      echo -e "\e[31mFAILURE\e[0m"
      exit 1
    fi
}
 DOWNLOAD(){
   echo downloading ${component}application content
   curl -s -L -o /tmp/${component}.zip "https://github.com/roboshop-devops-project/${component}/archive/main.zip"&>>/tmp/${component}.log
   cd /home/roboshop&>>/tmp/${component}.log
   StatusCheck
}

APP_USER_SETUP() {
     id roboshop &>>${LOG}
     if [ $? -ne 0 ]; then
       echo Adding Application User
       useradd roboshop &>>${LOG}
       StatusCheck
     fi
   }

   APP_CLEAN() {
     echo Cleaning old application content
     cd /home/roboshop &>>${LOG} && rm -rf ${component} &>>${LOG}
     StatusCheck

     echo Extract Application Archive
     unzip -o /tmp/${component}.zip &>>${LOG} && mv ${component}-main ${component} &>>${LOG} && cd ${component} &>>${LOG}
     StatusCheck
   }

   SYSTEMD() {
     echo Update SystemD Config
     sed -i -e 's/MONGO_DNSNAME/mongodb-dev.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb-dev.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis-dev.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue-dev.roboshop.internal/' -e 's/AMQPHOST/rabbitmq-dev.roboshop.internal/' -e 's/CARTHOST/cart-dev.roboshop.internal/' -e 's/USERHOST/user-dev.roboshop.internal/' -e 's/CARTENDPOINT/cart-dev.roboshop.internal/' -e 's/DBHOST/mysql-dev.roboshop.internal/' /home/roboshop/${component}/systemd.service &>>${LOG}
     StatusCheck

     echo Configuring ${component} SystemD Service
     mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service &>>${LOG} && systemctl daemon-reload &>>${LOG}
     StatusCheck

     echo Starting ${component} Service
     systemctl restart ${component} &>>${LOG} && systemctl enable ${component} &>>${LOG}
     StatusCheck
   }



NodeJS(){
  echo setting nodeJS repos
   curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${component}.log
   StatusCheck

   echo installing NodeJS
   yum install nodejs -y&>>/tmp/${component}.log
  StatusCheck

    APP_USER_SETUP
    DOWNLOAD
    APP_CLEAN

   echo installing NodeJS dependencies
   npm install&>>/tmp/${component}.log
   StatusCheck
   
    SYSTEMD
}

PYTHON() {
  echo Install Python
  yum install python36 gcc python3-devel -y &>>${LOG}
  StatusCheck


  APP_USER_SETUP
  DOWNLOAD
  APP_CLEAN

  echo Install Python Dependencies
  cd /home/roboshop/payment && pip3 install -r requirements.txt &>>${LOG}
  StatusCheck

  SYSTEMD
}
JAVA() {
  echo Install Maven
  yum install maven -y &>>${LOG}
  StatusCheck

  APP_USER_SETUP
  DOWNLOAD
  APP_CLEAN

  echo Make application package
  mvn clean package &>>${LOG} && mv target/shipping-1.0.jar shipping.jar &>>${LOG}
  StatusCheck

  SYSTEMD
}
   USER_ID=$(id -u)
   if [ $USER_ID -ne 0 ]; then
     echo -e "\e[31m You should run this script as root user or sudo\e[0m"
     exit 1
   fi

   LOG=/tmp/${component}.log
   rm -f ${LOG}


