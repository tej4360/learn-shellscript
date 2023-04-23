source Roboshop/common.sh
app_user=roboshop
component=user
schema_setup=mongo
print_head "download nodejs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_path
fun_stat_check $?
print_head "install nodejs"
yum install nodejs -y &>>log_path
fun_stat_check $?
print_head "check user"
fun_check_user
fun_get_app_content
print_head "install nodejs dependancies"
npm install &>>log_path
fun_stat_check $?
fun_schema_setup
func_systemd_setup
