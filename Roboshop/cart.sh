script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=cart
print_head "download node js"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_path
fun_stat_check $?
print_head "install node js"
yum install nodejs -y &>>log_path
fun_stat_check $?
fun_check_user
fun_get_app_content
func_systemd_setup
