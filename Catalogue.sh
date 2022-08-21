
source Common.sh
component=Catalouge

NodeJS


 echo installing services
 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
 systemctl daemon-reload
 systemctl start catalogue
 systemctl enable catalogue
