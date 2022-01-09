# CA1 Demo file
# Name: Conor Murphy

# Set up the queue
$QueueUrl = (aws sqs create-queue --queue-name caq |ConvertFrom-Json).QueueUrl
Write-Host "queue URL: $QueueUrl"

# Put Queue name into qprocessor.service
(Get-Content qprocessor_template.service -Raw) -replace '__QUEUE__',$QueueUrl | Out-File qprocessor.service -Encoding Ascii

# Create the S3 bucket
$BucketName='conor-cloud-ca'
aws s3 mb s3://$BucketName
aws s3 cp qprocessor.py s3://$BucketName/qprocessor.py
aws s3 cp qprocessor.service s3://$BucketName/qprocessor.service

# Put bucket name into user_data.sh
(Get-Content user_data_template.sh -Raw ) -replace '__BUCKETNAME__',$BucketName | Out-File user_data.sh -Encoding Ascii

Write-Host '----------------------------------------'

Write-Host ' You need to put the queue link into $QUrl value so etc $QUrl = ''https://queue.amazonaws.com/xxx/xxx'' on Powershell on Host PC'

Write-Host ' To connect to the AWS EC2, copy the IP Address from Powershell Host PC into the command ssh ec2-user@xx.xxx.xxx.xxx -i ~/.ssh/labsuser.pem where the x''s are'

Write-Host ' Once you type in the IP Address, Just click Yes to continue to connecting to the EC2 '

Write-Host ' Run the git repository command to download the git command on AWS EC2 by the command sudo yum install git -y '

Write-Host ' To doownload the GitHub repository folder, use the command git clone https://github.com/x-Dash-x/cloud_ca.git '

Write-Host ' You need to get into the folder directory containing the qprocessor.py so use the command cd ''file-name' 'command and use ls command to display directories'

Write-Host ' You need to go into the qprocessor.py by using the command ' 'nano qprocessor.py'''

Write-Host ' You need to put the queue url in the command print(''usage: python3 qprocessor.py https://queue_url_here/ out_file_path) where it says https://queue_url_here/'

Write-Host ' Once that is done, you have to put the Queue Url into where the x''s are' 'when you type the command ''python3 qprocessor.py https://queue.amazonaws.com/xxx/caq qmessages.txt '''''

Write-Host ' On Host Powershell, to send a message to the queue. Use the command aws sqs send-message --queue-url $QUrl --message-body "Test msg"'

