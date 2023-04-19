echo -e "\e[36m Copy mongo repo\e[0m"
cp /root/learnshell/Roboshop/mongo.repo /root/etc/yum.repos.d/mongo.repo
echo -e "\e[36minstall mongodb\e[0m"
yum install mongodb-org -y
echo -e "\e[36m start mongodb\e[0m"
systemctl enable mongod
systemctl start mongod
echo -e "\e[36m update mongo listen IP\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0' /root/etc/mongo.conf
echo -e "\e[36m restart mongo\e[0m"
systemctl restart mongod