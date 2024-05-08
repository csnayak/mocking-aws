provider "aws" {
  region                  = "us-east-1"
  access_key              = "mock_access_key"
  secret_key              = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Set default endpoint for all services
  endpoints {
    default = "http://localhost:4566"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-785db401"  # Use any available AMI
  instance_type = "t2.micro"
}
