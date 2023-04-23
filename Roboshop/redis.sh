source /learnshell/Roboshop/common.sh
component=redis
rm -rf /etc/roboshop.log
print_head "download redis"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_path
fun_stat_check $?
print_head "enable redis version 6.2"
dnf module enable redis:remi-6.2 -y &>>$log_path
fun_stat_check $?
print_head "install redis"
yum install redis -y &>>$log_path
fun_stat_check $?
print_head "update redis listen port in /etc/redis.conf"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/$component.conf &>>$log_path
fun_stat_check $?
print_head "update redis listen port in /etc/redis/redis.conf"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/$component.conf &>>$log_path
fun_stat_check $?
print_head "start redis"
systemctl enable redis &>>$log_path
systemctl start redis &>>$log_path
fun_stat_check $?