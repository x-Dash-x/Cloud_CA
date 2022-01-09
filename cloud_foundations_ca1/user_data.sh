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
BUCKET=conor-cloud-ca
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


