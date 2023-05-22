script=$(realpath "$0")
script_path=$(dirname "$script")
source $script_path/common.sh
component=cart
rm -rf log_path
print_head "<<<Setup Node JS>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>log_path
fun_stat_check $?
print_head "<<<install nodejs>>>"
yum install nodejs -y &>>log_path &>>log_path
fun_stat_check $?
print_head "<<<Add application user roboshop>>>"
useradd roboshop &>>log_path
print_head "remove /app dir"
rm -rf /app &>>log_path
fun_stat_check $?
print_head "Create app dir"
mkdir /app &>>log_path
fun_stat_check $?
print_head "download application content"
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>log_path
cd /app
unzip /tmp/$component.zip &>>log_path
fun_stat_check $?
print_head  "install dependencies"
npm install &>>log_path
fun_stat_check $?
print_head "copy cart service"
cp $script_path/$component.service /etc/systemd/system/$component.service &>>log_path
fun_stat_check $?
print_head  "load cart service"
systemctl daemon-reload &>>log_path
systemctl enable $component &>>log_path
systemctl start $component &>>$log_path
fun_stat_check $?
