source /learnshell/Roboshop/common.sh
print_head "Copy mongo repo"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo
fun_stat_check $?
print_head "install mongodb"
yum install mongodb-org -y
fun_stat_check $?
print_head "update mongo listen IP"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
fun_stat_check $?
print_head "start mongo"
systemctl enable mongod
systemctl restart mongod
fun_stat_check $?