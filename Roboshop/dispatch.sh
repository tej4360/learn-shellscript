script=$(realpath "$0")
script_path=$(dirname "$script")
log_path=/etc/roboshop_log
component=dispatch
rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit
fi

print_head "install go lang"
yum install golang -y &>>$log_path
fun_stat_check $?

fun_check_user

fun_get_app_content

print_head "go lang sepcif commands"
go mod init dispatch
go get
go build
func_systemd_setup


