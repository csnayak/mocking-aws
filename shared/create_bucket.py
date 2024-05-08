import boto3

def create_bucket_with_tags(bucket_name, tags):
    # Connect to the moto S3 mock server with dummy credentials
    s3 = boto3.client(
        's3', 
        region_name='us-east-1',
        endpoint_url='http://localhost:3000',
        aws_access_key_id='fake_access_key',
        aws_secret_access_key='fake_secret_key'
    )
    
    # Create the bucket
    s3.create_bucket(Bucket=bucket_name)
    
    # Define the tags
    tag_set = [{'Key': key, 'Value': value} for key, value in tags.items()]
    
    # Put tags on the bucket
    s3.put_bucket_tagging(
        Bucket=bucket_name,
        Tagging={
            'TagSet': tag_set
        }
    )
    
    # Confirm bucket creation and display tags
    response = s3.list_buckets()
    for bucket in response['Buckets']:
        print(f"Created bucket: {bucket['Name']}")
    print(f"Tags for {bucket_name}: {tags}")

if __name__ == "__main__":
    bucket_name = "my-mock-bucket"
    tags = {
        "Project": "Test",
        "Owner": "DevOps"
    }
    create_bucket_with_tags(bucket_name, tags)

