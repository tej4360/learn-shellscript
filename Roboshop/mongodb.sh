script=$(realpath "$0")
script_path=$(dirname "$script)")
source $script_path/common.sh
print_head "Copy mongo repo"
cp $script_path/mongo.repo /etc/yum.repos.d/mongodb.repo &>>$log_path
fun_stat_check $?
print_head "install mongodb"
yum install mongodb-org -y &>>$log_path
fun_stat_check $?
print_head "update mongo listen IP"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>$log_path
fun_stat_check $?
print_head "start mongo"
systemctl enable mongod &>>$log_path
systemctl restart mongod &>>$log_path
fun_stat_check $?