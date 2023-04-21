source /learnshell/Roboshop/common.sh
print_head "Copy mongo repo"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo &>>/etc/roboshop_log
fun_stat_check $?
print_head "install mongodb"
yum install mongodb-org -y &>>/etc/roboshop_log
fun_stat_check $?
print_head "update mongo listen IP"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>/etc/roboshop_log
fun_stat_check $?
print_head "start mongo"
systemctl enable mongod &>>/etc/roboshop_log
systemctl restart mongod &>>/etc/roboshop_log
fun_stat_check $?