#!/bin/bash
sudo apt update && sudo apt upgrade -y
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install collectd nodejs awscli ruby-full -y
sudo apt install gcc make -y
sudo npm install -g npm@latest
sudo npm install -g pm2@latest
sudo wget https://s3.us-west-2.amazonaws.com/amazoncloudwatch-agent-us-west-2/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto > /tmp/logfile
rm -rf amazon-cloudwatch-agent.deb
rm -rf install
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent
sudo systemctl restart codedeploy-agent