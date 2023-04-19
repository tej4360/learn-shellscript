echo -e "\e[36m Copy mongo repo\e[0m"
cp Roboshop/mongo.repo /etc/yum.repos.d/mongodb.repo
echo -e "\e[36minstall mongodb\e[0m"
yum install mongodb-org -y


echo -e "\e[36m update mongo listen IP\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0' /etc/mongod.conf
echo -e "\e[36m start mongo\e[0m"
systemctl enable mongod
systemctl restart mongod