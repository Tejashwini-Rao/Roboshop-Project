   source Common.sh
   component=frontend

   echo Installing Nginx
   yum install nginx -y &>> ${LOG}
   StatusCheck

   DOWNLOAD

   echo Cleaning old content
   cd /usr/share/nginx/html&&rm -rf *
   StatusCheck

   echo Extract Downloaded content
   unzip /tmp/frontend.zip&>>${LOG} && mv frontend-main/static/* . && mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
   StatusCheck

   echo Stating Nginx
   systemctl restart nginx &>>${LOG} && systemctl enable nginx &>>{LOG}
   StatusCheck
