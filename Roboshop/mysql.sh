script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  print_head "Input MySQL Root Password Missing"
  exit 1
fi


print_head "Disable MySQL 8 Version"
dnf module disable mysql -y &>>$log_path
func_stat_check $?

print_head "Copy MySQL Repo File"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_path
func_stat_check $?

print_head "Install MySQL"
yum install mysql-community-server -y &>>$log_path
func_stat_check $?

print_head "Start MySQL"
systemctl enable mysqld &>>$log_path
systemctl restart mysqld &>>$log_path
func_stat_check $?

print_head "Reset MySQL Password"
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_path
func_stat_check $?