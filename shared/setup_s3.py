import boto3

# Set dummy AWS credentials
s3 = boto3.client(
    's3',
    region_name='us-east-1',
    aws_access_key_id='fake_access_key',
    aws_secret_access_key='fake_secret_key',
    endpoint_url='http://localhost:5000'
)

def list_buckets():
    buckets = s3.list_buckets()
    for bucket in buckets['Buckets']:
        print(bucket['Name'])

# Create a new bucket
s3.create_bucket(Bucket='my-moto-bucket')

# Call the list_buckets function
list_buckets()





