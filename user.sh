echo -e "\e[32m<<<<<<<<<< Disable current nodejs module>>>>>>>\e[0m"

dnf module disable nodejs -y

echo -e "\e[32m<<<<<<<<<< Enable 18 Version nodejs module>>>>>>>\e[0m"

dnf module enable nodejs:18 -y

echo -e "\e[32m<<<<<<<<<< Install nodejs >>>>>>>\e[0m"

dnf install nodejs -y
echo -e "\e[32m<<<<<<<<<< Copy user service systemd file >>>>>>>\e[0m"

cp user.service /etc/systemd/system/user.service
echo -e "\e[32m<<<<<<<<<< Create roboshop user >>>>>>>\e[0m"

useradd roboshop
rm -rf /app
mkdir /app 

echo -e "\e[32m<<<<<<<<<< Download user zip file >>>>>>>\e[0m"

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 
echo -e "\e[32m<<<<<<<<<< Unzip user files >>>>>>>\e[0m"


unzip /tmp/user.zip
cd /app 

echo -e "\e[32m<<<<<<<<<< Install nodejs Dependencies >>>>>>>\e[0m"

npm install 

echo -e "\e[32m<<<<<<<<<< Restart user Service >>>>>>>\e[0m"

systemctl daemon-reload
systemctl enable user 
systemctl start user

cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.cloudlife.site </app/schema/user.js

