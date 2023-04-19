echo -e "\e[36m download nodejs\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m install nodejs\e[0m"

yum install nodejs -y
echo -e "\e[36m user add\e[0m"
useradd roboshop
echo -e "\e[36m create app dir \e[0m"
rm -rf /app
mkdir /app
echo -e "\e[36m download application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
echo -e "\e[36m unzip application content \e[0m"
unzip /tmp/catalogue.zip -y
cd /app
echo -e "\e[36m install dependencies\e[0m"
npm install
echo -e "\e[36m copy catologue service\e[0m"
cp /learnshell/Roboshop/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[36m load catalogue service\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
echo -e "\e[36m install mongo\e[0m"
cp /learnshell/Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
echo -e "\e[36m load schema\e[0m"
mongo --host mongo.rtdevopspract.online </app/schema/catalogue.js