 set -e
 curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo

 yum install mysql-community-server -y

 systemctl enable mysqld
 systemctl start mysqld

 # shellcheck disable=SC2034
 DEFAULT_PASSWORD=$(grep ' A temporary password' /var/log/mysqld.log | awk '{print $NF}')

 echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';'RoboShop@1'; "| mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD}

 mysql -uroot -pRoboShop@1
#> uninstall plugin validate_password;
 curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

 cd /tmp
 unzip -o  mysql.zip
 cd mysql-main
 mysql -u root -pRoboShop@1 <shipping.sql