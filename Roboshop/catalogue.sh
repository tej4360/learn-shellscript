source /learnshell/Roboshop/common.sh
rm -rf /tmp/roboshop_log
print_head "<<<Setup Node JS>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop_log
fun_stat_check $?
print_head "<<<install nodejs>>>"
yum install nodejs -y &>>/tmp/roboshop_log &>>/tmp/roboshop_log
fun_stat_check $?
print_head "<<<Add application user roboshop>>>"
useradd roboshop &>>/tmp/roboshop_log &>>/tmp/roboshop_log
print_head "remove /app dir"
rm -rf /app &>>/tmp/roboshop_log
fun_stat_check $?
print_head "Create app dir"
mkdir /app &>>/tmp/roboshop_log
fun_stat_check $?
print_head "download application content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop_log
cd /app
unzip /tmp/catalogue.zip &>>/tmp/roboshop_log
fun_stat_check $?
print_head  "install dependencies"
npm install &>>/tmp/roboshop_log
fun_stat_check $?
cd /learnshell
print_head "copy mongo repo file"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop_log
fun_stat_check $?
print_head "install mongodb"
yum install mongodb-org-shell -y &>>/tmp/roboshop_log
fun_stat_check $?
print_head "load schema"
mongo --host mongo.rtdevopspract.online </app/schema/catalogue.js &>>/tmp/roboshop_log
fun_stat_check $?
print_head "copy catologue service"
cp Roboshop/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop_log
fun_stat_check $?
print_head  "load catalogue service"
systemctl daemon-reload &>>/tmp/roboshop_log
systemctl enable catalogue &>>/tmp/roboshop_log
systemctl start catalogue &>>/tmp/roboshop_log
fun_stat_check $?
