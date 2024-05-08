from moto import mock_aws
import boto3

@mock_aws
def setup_s3_environment():
    # Create an S3 service client
    s3 = boto3.client('s3', region_name='us-east-1')
    
    # Create buckets
    s3.create_bucket(Bucket='MyPublicBucket')
    s3.create_bucket(Bucket='MyPrivateBucket')
    
    # Apply public access block to one bucket
    s3.put_public_access_block(
        Bucket='MyPrivateBucket',
        PublicAccessBlockConfiguration={
            'BlockPublicAcls': True,
            'IgnorePublicAcls': True,
            'BlockPublicPolicy': True,
            'RestrictPublicBuckets': True
        }
    )

# Execute the setup function
setup_s3_environment()








