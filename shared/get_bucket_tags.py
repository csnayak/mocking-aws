import boto3

def get_bucket_tags(bucket_name):
    # Connect to the moto S3 mock server with dummy credentials
    s3 = boto3.client(
        's3',
        region_name='us-east-1',
        endpoint_url='http://localhost:3000',
        aws_access_key_id='fake_access_key',
        aws_secret_access_key='fake_secret_key'
    )
    
    # Retrieve the tags for the specified bucket
    try:
        response = s3.get_bucket_tagging(Bucket=bucket_name)
        tags = response['TagSet']
        print(f"Tags for {bucket_name}:")
        for tag in tags:
            print(f"{tag['Key']}: {tag['Value']}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    bucket_name = "my-mock-bucket"
    get_bucket_tags(bucket_name)
