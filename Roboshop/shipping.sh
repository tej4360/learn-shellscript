script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=shipping
schema_setup=mysql
mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
  echo Input MySQL Root Password Missing
  exit
fi
func_print_head "Install Maven"
yum install maven -y &>>$log_file
func_stat_check $?
fun_check_user
fun_get_app_content
func_print_head "Download Maven Dependencies"
mvn clean package &>>$log_file
func_stat_check $?
mv target/${component}-1.0.jar ${component}.jar &>>$log_file
func_schema_setup
print_head "Update Passwords in System Service file"
sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service &>>$log_path
func_systemd_setup