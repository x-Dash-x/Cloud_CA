# CA1 user data file
# Name: Conor Murphy

#!/bin/bash
yum -y update
yum -y install httpd git elinks
systemctl enable httpd
systemctl start httpd

#!/bin/bash

# Software updates
yum -y update

# Set the AWS configuration
cd /root
mkdir -p .aws
echo '[default]
region=us-east-1
' > .aws/config

# Copy aws config to the ec2-user
cp -r .aws /home/ec2-user

cd /home/ec2-user
chown -R ec2-user .aws 

# Get the qprocessor.py file
BUCKET=conor-cloudinit-lab
aws s3 cp s3://$BUCKET/qprocessor.py . 
chown -R ec2-user qprocessor.py

# Install boto3 library
pip3 install boto3

# Service unit file 
aws s3 cp s3://$BUCKET/qprocessor.service /etc/systemd/system/qprocessor.service

# Service setup & startup
systemctl daemon-reload 
systemctl enable qprocessor
systemctl start qprocessor

# Write file to confirm done
echo 'all done' > status.txt


