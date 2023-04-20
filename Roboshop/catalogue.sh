source /learnshell/Roboshop/common.sh
rm -rf /app/roboshop_log
print_head "<<<Setuop Node JS>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/app/roboshop_log
print_head "<<<install nodejs>>>"

yum install nodejs -y &>>/app/roboshop_log
print_head("Add application user roboshop")
id roboshop
if ["$?" != 0] then
  useradd roboshop
if
print_head "Create app dir"
rm -rf /app
mkdir /app
print_head "download application content"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/app/roboshop_log
cd /app
print_head "Unzip application content"
unzip /tmp/catalogue.zip -y &>>/app/roboshop_log
print_head  "install dependencies"
npm install &>>/app/roboshop_log
cd /learnshell
print_head "copy catologue service"
cp Roboshop/catalogue.service /etc/systemd/system/catalogue.service
print_head  "load catalogue service"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
print_head "install mongo"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y &>>/app/roboshop_log
eprint_head "load schema"
mongo --host mongo.rtdevopspract.online </app/schema/catalogue.js