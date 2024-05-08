from moto import mock_aws
import boto3
import json

@mock_aws
def setup_serverless_architecture():
    # Initialize AWS clients within the mock context
    iam = boto3.client('iam', region_name='us-east-1')
    s3 = boto3.client('s3', region_name='us-east-1')
    sqs = boto3.client('sqs', region_name='us-east-1')
    lambda_client = boto3.client('lambda', region_name='us-east-1')
    api_client = boto3.client('apigateway', region_name='us-east-1')

    # Create an S3 bucket
    bucket_name = 'my-mock-bucket'
    s3.create_bucket(Bucket=bucket_name)
    print(f"Bucket '{bucket_name}' created.")

    # Create an SQS queue
    queue_name = 'my-mock-queue'
    queue_response = sqs.create_queue(QueueName=queue_name)
    print(f"Queue '{queue_name}' created with URL {queue_response['QueueUrl']}.")

    # Create a mock IAM role
    role_name = "DummyRoleForLambda"
    assume_role_policy = json.dumps({
        "Version": "2012-10-17",
        "Statement": [{
            "Action": "sts:AssumeRole",
            "Principal": {"Service": "lambda.amazonaws.com"},
            "Effect": "Allow",
            "Sid": ""
        }]
    })
    role = iam.create_role(
        RoleName=role_name,
        AssumeRolePolicyDocument=assume_role_policy,
        Path="/"
    )
    role_arn = role['Role']['Arn']
    print(f"IAM Role '{role_name}' created with ARN: {role_arn}.")

    # Lambda function code
    lambda_code = "def lambda_handler(event, context): return {'statusCode': 200, 'body': 'Hello from Lambda!'}"

    # Create a Lambda function using the mock role ARN
    lambda_response = lambda_client.create_function(
        FunctionName='MyMockLambda',
        Runtime='python3.8',
        Role=role_arn,
        Handler='index.lambda_handler',
        Code={'ZipFile': lambda_code.encode()},
        Timeout=15,
    )
    lambda_arn = lambda_response['FunctionArn']
    print(f"Lambda function 'MyMockLambda' created with ARN: {lambda_arn}.")

    # Create a REST API via API Gateway
    api_response = api_client.create_rest_api(
        name='MyMockAPI'
    )
    root_id = api_response['id']
    resources = api_client.get_resources(restApiId=root_id)
    root_resource_id = resources['items'][0]['id']

    # Create a GET method and integrate with Lambda
    api_client.put_method(
        restApiId=root_id,
        resourceId=root_resource_id,
        httpMethod='GET',
        authorizationType='NONE'
    )
    api_client.put_integration(
        restApiId=root_id,
        resourceId=root_resource_id,
        httpMethod='GET',
        type='AWS',
        integrationHttpMethod='POST',
        uri=f"arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/{lambda_arn}/invocations"
    )
    print(f"API Gateway 'MyMockAPI' set up to trigger Lambda.")

if __name__ == "__main__":
    setup_serverless_architecture()


