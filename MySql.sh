 set -e
 curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo

 yum install mysql-community-server -y

 systemctl enable mysqld
 systemctl start mysqld

 # shellcheck disable=SC2034
 DEFAULT_PASSWORD = $(grep ' A temporary password' /var/log/mysqld.log | awk '{print $NF}')
 echo ALTER USER 'root'@'localhost' IDENTIFIED BY '-pRoboShop@1'; | mysql -uroot -p${DEFAULT_PASSWORD}


 mysql_secure_installation
 mysql -uroot -pRoboShop@1
#> uninstall plugin validate_password;
 curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

 cd /tmp
 unzip -o  mysql.zip
 cd mysql-main
 mysql -u root -pRoboShop@1 <shipping.sql