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
      echo -e "\e[35m ******Failure****** \e[0m"
      print_head "*** Please refer /etc/roboshop_log file for detail report *****"
      exit 1
  fi
}
fun_check_user() {
  print_head "in user check function"
  id $app_user &>>log_path
  if [ $? -ne 0]; then
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
  print_head "ext app data"
  cd /app
  unzip /tmp/$component.zip &>>log_path
  fun_stat_check $?
}
fun_schema_setup() {
  if [ "$schema_setup" == "mongo" ]; then
    print_head "copy mongo repo"
    cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo &>>$log_file
    fun_stat_check $?
    print_head "install mongo schema"
    yum install mongodb-org-shell -y &>>$log_file
    func_stat_check $?
    print_head "Load Schema"
    mongo --host mongo.rtdevopspact.online </app/schema/${component}.js &>>$log_file
    func_stat_check $?
  fi
}