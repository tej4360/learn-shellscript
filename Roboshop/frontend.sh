##frontend shell automation
script=$(realpath "$0")
script_path=$(dirname "$script")
component=frontend
source $script_path/common.sh
rm -rf $log_path
print_head "install NGINX"
yum install nginx -y &>>$log_path
fun_stat_check $?
fun_get_app_content
func_systemd_setup

