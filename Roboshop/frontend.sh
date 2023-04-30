script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

rm -rf $log_path

print_head "Install Nginx"
yum install nginx -y &>>$log_path
fun_stat_check $?

print_head "Copy roboshop Config file"
cp $script_path/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_path
fun_stat_check $?

print_head "Clean Old App content"
rm -rf /usr/share/nginx/html/* &>>$log_path
fun_stat_check $?

print_head "Download App Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_path
fun_stat_check $?

print_head "Extracting App Content"
cd /usr/share/nginx/html &>>$log_path
unzip /tmp/frontend.zip &>>$log_path
fun_stat_check $?

print_head "Start Nginx"
systemctl enable nginx &>>$log_path
systemctl restart nginx &>>$log_path
fun_stat_check $?
