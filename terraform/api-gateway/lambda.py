import json
import os

def lambda_handler(event, context):
    print(os.environ.get('iam'))
    return{
        'statusCode': 200,
        'body' : json.dumps('Hello World!!')
    }