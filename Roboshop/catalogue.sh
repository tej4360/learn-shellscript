source /learnshell/Roboshop/common.sh
#rm -rf /app/roboshop_log
print_head "<<<Setuop Node JS>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
fun_stat_check $?
print_head "<<<install nodejs>>>"
yum install nodejs -y &>>/app/roboshop_log
fun_stat_check $?
print_head "<<<Add application user roboshop>>>"
useradd roboshop &>>/app/roboshop_log
rm -rf /app
fun_stat_check $?
print_head "Create app dir"
mkdir /app
fun_stat_check $?
print_head "download application content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
fun_stat_check $?
print_head  "install dependencies"
npm install
fun_stat_check $?
cd /learnshell
print_head "install mongo"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo
fun_stat_check $?
yum install mongodb-org-shell -y
fun_stat_check $?
print_head "load schema"
mongo --host mongo.rtdevopspract.online </app/schema/catalogue.js
fun_stat_check $?
print_head "copy catologue service"
cp Roboshop/catalogue.service /etc/systemd/system/catalogue.service
fun_stat_check $?
print_head  "load catalogue service"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
fun_stat_check $?
