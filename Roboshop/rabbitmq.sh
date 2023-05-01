script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=rabbitmq
rabbitmq_appuser_password=$1

if [ -z "$rabbitmq_appuser_password" ]; then
  print_head "Rabbitmq app user password required"
  exit
fi

print_head "setup erlang repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_path
fun_stat_check $?

print_head "Setup RabbitMQ Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_path
fun_stat_check $?

print_head "Install ErLang & RabbitMQ"
yum install erlang rabbitmq-server -y &>>$log_path
fun_stat_check $?

print_head "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>$log_path
systemctl restart rabbitmq-server &>>$log_path
fun_stat_check $?

func_print_head "Add Application User in RabbtiMQ"
rabbitmqctl add_user roboshop ${rabbitmq_appuser_password} &>>$log_path
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_path
fun_stat_check $?