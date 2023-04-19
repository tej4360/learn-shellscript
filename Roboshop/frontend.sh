##frontend shell automation
echo -e "\e[36minstall NGINX\e[0m"
yum install nginx -y
echo -e "\e[36m enable NGINX\e[0m"
systemctl enable nginx
systemctl start nginx
echo -e "\e[36m remove application content\e[0m"
rm -rf /usr/share/nginx/html/*
echo -e "\e[36mdownload application content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo -e "\e[36munzip front end\e[0m"
unzip /tmp/frontend.zip
echo -e "\e[36m copy config file\e[0m"
cp /root/learnshell/Roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx

