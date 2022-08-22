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

NodeJS(){
  echo setting nodeJS repos
   curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/${component}.log
   StatusCheck

   echo installing NodeJS
   yum install nodejs -y&>>/tmp/${component}.log
  StatusCheck

   id roboshop&>>/tmp/${component}.log
   if [ $? -ne 0 ]; then
     echo adding user
     useradd roboshop&>>/tmp/${component}.log
     StatusCheck
    fi

    DOWNLOAD

   echo cleaning old application
   rm -rf ${component}&>>/tmp/${component}.log
   StatusCheck

  echo extracting application archives
   unzip -o /tmp/${component}.zip&>>/tmp/${component}.log && mv ${component}-main ${component}&>>/tmp/${component}.log&&cd ${component}&>>/tmp/${component}.log
  StatusCheck

   echo installing NodeJS dependencies
   npm install&>>/tmp/${component}.log
   StatusCheck
   
    echo configuring ${component} services
     mv /home/roboshop/${component}/systemd.service /etc/systemd/system/${component}.service&>>/tmp/${component}.log && systemctl daemon-reload&>>/tmp/${component}.log
     StatusCheck
   
     echo starting ${component} services
     systemctl start ${component}&>>/tmp/${component}.log
     systemctl enable ${component}&>>/tmp/${component}.log
     StatusCheck
}
   USER_ID=$(id -u)
   if [ $USER_ID -ne 0 ]; then
     echo -e "\e[31m You should run this script as root user or sudo\e[0m"
     exit 1
   fi

   LOG=/tmp/${COMPONENT}.log
   rm -f ${LOG}


