script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=mysql
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo Input MySQL Root Password Missing
  exit 1
fi
#print_head "MYSQ Password - ${mysql_root_password}"
rm -rf $log_path
print_head "Disable MySQL 8 Version"
dnf module disable mysql -y &>>$log_path
fun_stat_check $?
print_head "copy mysql repo file"
cp $script_path/$component.repo /etc/yum.repos.d/$component.repo &>>log_path
fun_stat_check $?
print_head "install mysql"
yum install mysql-community-server -y &>>$log_path
fun_stat_check $?
print_head "Start MySQL"
systemctl enable mysqld &>>$log_path
systemctl restart mysqld &>>$log_path
fun_stat_check $?
print_head "Reset MySQL Password to : ${mysql_root_password}"
mysql_secure_installation --set-root-pass $mysql_root_password
fun_stat_check $?
