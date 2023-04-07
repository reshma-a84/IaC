import boto3
import json

iam_resource = boto3.client('iam')
role = iam_resource.create_role(RoleName='kinesis-analytics-assume-role', 
                                AssumeRolePolicyDocument=json.dumps({
                                    'Version': '2012-10-17',
                                    'Statement': [{
                                        'Effect': 'Allow',
                                        'Principal': {
                                            'Service': 'kinesisanalytics.amazonaws.com'
                                        },
                                        'Action': 'sts:AssumeRole'
                                        
                                    }]
                                }))