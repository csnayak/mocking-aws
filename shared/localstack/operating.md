## Pull the localstack docker image
docker pull localstack/localstack

## Run localstack
docker run --rm -it -p 4566:4566 -p 4571:4571 -e SERVICES=s3,sqs,dynamodb localstack/localstack

sudo docker run --rm -it -p 4566:4566 -e SERVICES=lambda,s3,sqs,dynamodb localstack/localstack

sudo docker run --rm -it \
  -p 4566:4566 \
  -p 4510-4559:4510-4559 \
  localstack/localstack


## Creating a S3 bucket using aws cli
aws --profile localstack s3api create-bucket --bucket my-test-bucket

## list s3 buckets
aws --profile localstack s3 ls

## listing Lambda functions
aws --profile localstack lambda list-functions

aws --profile localstack ec2 describe-images
aws --profile localstack ec2 describe-instances
aws --profile localstack  ec2 describe-images --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*" "Name=state,Values=available" --query "Images[*].{ID:ImageId, Name:Name, Description:Description}" --output json


aws ec2 start-instances --instance-ids i-622df2cd229125681 --profile localstack

aws ec2 stop-instances --instance-ids i-622df2cd229125681 --profile localstack

aws ec2 terminate-instances --instance-ids i-622df2cd229125681 --profile localstack


## Docker compose experiment
sudo docker-compose up
sudo docker-compose down
sudo lsof /tmp/localstack
sudo rm -rf /tmp/localstack
sudo systemctl restart docker

## To ensure a clean start, let's follow these steps:
sudo docker stop $(sudo docker ps -a -q)
sudo docker rm $(sudo docker ps -a -q)
sudo rm -rf /tmp/localstack



