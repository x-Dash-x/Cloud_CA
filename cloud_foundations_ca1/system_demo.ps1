# CA1 Demo file
# Name: Conor Murphy



# Set up the queue
$QueueUrl = (aws sqs create-queue --queue-name labq |ConvertFrom-Json).QueueUrl
Write-Host "queue URL: $QueueUrl"

# Put Queue name into qprocessor.service
(Get-Content qprocessor_template.service -Raw) -replace '__QUEUE__',$QueueUrl | Out-File qprocessor.service -Encoding Ascii

# Create the S3 bucket
$BucketName='conor-cloudinit-lab'
aws s3 mb s3://$BucketName
aws s3 cp qprocessor.py s3://$BucketName/qprocessor.py
aws s3 cp qprocessor.service s3://$BucketName/qprocessor.service

# Put bucket name into user_data.sh
(Get-Content user_data_template.sh -Raw ) -replace '__BUCKETNAME__',$BucketName | Out-File user_data.sh -Encoding Ascii

Write-Host ' You need to put the queue link into $QUrl value so etc $QUrl = ''https://queue.amazonaws.com/xxx/xxx'''
Write-Host ' To connect to the AWS EC2, copy the IP Address into ssh ec2-user@xx.xxx.xxx.xxx -i ~/.ssh/labsuser.pem where the x''s are'
