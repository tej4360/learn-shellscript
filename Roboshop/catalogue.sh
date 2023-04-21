source /learnshell/Roboshop/common.sh
rm -rf /app/roboshop_log
print_head "<<<Setuop Node JS>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/app/roboshop_log
fun_stat_check $?
print_head "<<<install nodejs>>>"
yum install nodejs -y &>>/app/roboshop_log &>>/app/roboshop_log
fun_stat_check $?
print_head "<<<Add application user roboshop>>>"
useradd roboshop &>>/app/roboshop_log &>>/app/roboshop_log
rm -rf /app &>>/app/roboshop_log
fun_stat_check $?
print_head "Create app dir"
mkdir /app &>>/app/roboshop_log
fun_stat_check $?
print_head "download application content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/app/roboshop_log
cd /app
unzip /tmp/catalogue.zip &>>/app/roboshop_log
fun_stat_check $?
print_head  "install dependencies"
npm install &>>/app/roboshop_log
fun_stat_check $?
cd /learnshell
print_head "install mongo"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo &>>/app/roboshop_log
fun_stat_check $?
yum install mongodb-org-shell -y &>>/app/roboshop_log
fun_stat_check $?
print_head "load schema"
mongo --host mongo.rtdevopspract.online </app/schema/catalogue.js &>>/app/roboshop_log
fun_stat_check $?
print_head "copy catologue service"
cp Roboshop/catalogue.service /etc/systemd/system/catalogue.service &>>/app/roboshop_log
fun_stat_check $?
print_head  "load catalogue service"
systemctl daemon-reload &>>/app/roboshop_log
systemctl enable catalogue &>>/app/roboshop_log
systemctl start catalogue &>>/app/roboshop_log
fun_stat_check $?
