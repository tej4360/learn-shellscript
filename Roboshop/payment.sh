script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=payment
rabbitmq_appuser_password=$1
if [ -z "$rabbitmq_appuser_password" ]; then
  echo Input Roboshop Appuser Password Missing
  exit
fi

  print_head "Install Python"
  yum install python36 gcc python3-devel -y &>>$log_path
  func_stat_check $?

  fun_check_user
  fun_get_app_content

  print_head "Install Python Dependencies"
  pip3.6 install -r requirements.txt &>>$log_path
  func_stat_check $?

  print_head "Update Passwords in System Service file"
  sed -i -e "s|rabbitmq_appuser_password|${rabbitmq_appuser_password}|" ${script_path}/payment.service &>>$log_path
  func_stat_check $?

  func_systemd_setup