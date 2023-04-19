##frontend shell automation
source Roboshop/common.sh
print_head "install NGINX"
yum install nginx -y
print_head "enable NGINX"
systemctl enable nginx
systemctl start nginx
print_head "remove application content"
rm -rf /usr/share/nginx/html/*
print_head "download application content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
print_head  "unzip front end"
unzip /tmp/frontend.zip
print_head "copy config file"
cp /root/learnshell/Roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

