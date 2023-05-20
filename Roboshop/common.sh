script=$(realpath "$0")
script_path=$(dirname "$script")
log_path=/etc/roboshop_log
print_head(){
  echo -e "\e[36m $1 \e[0m"
}

fun_stat_check() {
  if [ $1 -eq 0 ]; then
      echo -e "\e[35m >>>>>Success<<<<<< \e[0m"
  else
      echo -e "\e[35m ******Failure****** $1 \e[0m"
      print_head "*** Please refer /etc/roboshop_log file for detail report *****"
      exit 1
  fi
}
fun_check_user() {
  print_head "in user check function"
  id $app_user &>>log_path
  if [ $? -ne 0 ]; then
    print_head "add app user"
    useradd $app_user &>>log_path
    fun_stat_check $?
  fi
}
fun_get_app_content() {
  print_head "in fun_get_app_content"
  rm -rf /app &>>log_path
  mkdir /app &>>log_path
  fun_stat_check $?
  print_head "download "$component" content"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_path
  fun_stat_check $?
  print_head "extract app data"
  cd /app
  unzip /tmp/$component.zip &>>log_path
  fun_stat_check $?
}
fun_schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
    print_head "copy mongo repo"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_path
    fun_stat_check $?
    print_head "install mongo schema"
    yum install mongodb-org-shell -y &>>$log_path
    fun_stat_check $?
    print_head "Load Schema"
    mongo --host mongo.rtdevopspract.online	 </app/schema/${component}.js &>>$log_path
    fun_stat_check $?
  fi
  if [ "$schema_setup" == "mysql "]; then
    print_head "install mysql"
    yum install mysql -y &>>$log_path
    fun_stat_check $?

    print_head "Load Schema"
    mysql -h mysql.rtdevopspract.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql &>>$log_file
    func_stat_check $?
  fi
}
func_systemd_setup() {
  print_head "Setup SystemD Service"
  cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>$log_path
  fun_stat_check $?
  print_head "Start ${component} Service"
  systemctl daemon-reload &>>$log_path
  systemctl enable ${component} &>>$log_path
  systemctl restart ${component} &>>$log_path
  fun_stat_check $?
}