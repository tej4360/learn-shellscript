##frontend shell automation
script=$(realpath "$0")
script_path=$(dirname "$script")
rm -rf $log_path
source $script_path/common.sh
print_head "install NGINX"
yum install nginx -y &>>$log_path
fun_stat_check $?
print_head "remove application content"
rm -rf /usr/share/nginx/html/* &>>$log_path
fun_stat_check $?
print_head "download application content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_path
fun_stat_check $?
cd /usr/share/nginx/html
print_head  "unzip front end"
unzip /tmp/frontend.zip &>>$log_path
fun_stat_check $?
print_head "copy config file"
cp $script_path/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_path
systemctl enable nginx &>>$log_path
systemctl restart nginx &>>$log_path
fun_stat_check $?

