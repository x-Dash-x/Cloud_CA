# Simple Python SQS consumer
# Conor Murphy

import sys

# must install boto3 to use this (pip3 install boto3)
import boto3

# get QueueUrl from command line
if len(sys.argv) < 2:
    print('usage: python3 qprocessor.py https://queue_url_here/ out_file_path')
    sys.exit(1)
queue_url=sys.argv[1]
out_file_path=sys.argv[2]

# client object for SQS
sqs = boto3.client('sqs')

wait_time_seconds = 1

def print_to_file(line):
    out_file=open(out_file_path,'a')
    print(line, file=out_file)
    out_file.close()

print_to_file('START')

while True:
    # receive
    response = sqs.receive_message(QueueUrl=queue_url, WaitTimeSeconds=wait_time_seconds, MaxNumberOfMessages=1)
    wait_time_seconds = 20

    if 'Messages' not in response:
        print('no messages hit Ctrl + Z to exit queue')
        continue

    # loop over all messages
    for message in response['Messages']:
        
        # do processing work here (example just prints)
        print("received: " + message['Body'])
        print_to_file(message['Body'])
        
        
        # delete once processed
        sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=message['ReceiptHandle'])
        

