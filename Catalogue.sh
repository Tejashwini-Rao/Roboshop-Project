
source Common.sh
component=Catalouge

 NodeJS



 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
 systemctl daemon-reload
 systemctl start catalogue
 systemctl enable catalogue
