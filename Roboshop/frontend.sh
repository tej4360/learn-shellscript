##frontend shell automation
rm -rf /etc/roboshop_log
source Roboshop/common.sh
print_head "install NGINX"
yum install nginx -y &>>/etc/roboshop_log
fun_stat_check $?
print_head "remove application content"
rm -rf /usr/share/nginx/html/* &>>/etc/roboshop_log
fun_stat_check $?
print_head "download application content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/etc/roboshop_log
fun_stat_check $?
cd /usr/share/nginx/html
print_head  "unzip front end"
unzip /tmp/frontend.zip &>>/etc/roboshop_log
fun_stat_check $?
print_head "copy config file"
cp /learnshell/Roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/etc/roboshop_log
systemctl enable nginx &>>/etc/roboshop_log
systemctl restart nginx &>>/etc/roboshop_log
fun_stat_check $?

