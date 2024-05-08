To install the AWS Lambda Runtime Interface Emulator (RIE) on Ubuntu Linux, you will need to have Docker installed, as RIE runs within a Docker container. Below, I provide the step-by-step guide to set up Docker, pull the RIE Docker image, and integrate it with a sample AWS Lambda function.

### Step 1: Install Docker on Ubuntu

Before installing the RIE, you must have Docker installed. Here’s how to install Docker on Ubuntu:

1. **Update your system:**
   ```bash
   sudo apt update
   sudo apt upgrade
   ```

2. **Install Docker:**
   ```bash
   sudo apt install docker.io
   ```

3. **Start and enable Docker:**
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

4. **Check Docker version to confirm installation:**
   ```bash
   docker --version
   ```

### Step 2: Pull the AWS Lambda Runtime Interface Emulator Docker Image

Once Docker is installed, you can pull the Docker image for the AWS Lambda Runtime Interface Emulator:

```bash
docker pull public.ecr.aws/lambda/provided:latest
```

### Step 3: Create a Sample Lambda Function

Create a directory for your Lambda project and move into it:

```bash
mkdir lambda-project
cd lambda-project
```

Create a simple Lambda function in a file named `app.py` (for Python functions):

```python
def handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Hello from Lambda RIE'
    }
```

### Step 4: Create a Dockerfile

Create a Dockerfile in the `lambda-project` directory:

```Dockerfile
FROM public.ecr.aws/lambda/python:3.8

# Copy the handler function
COPY app.py ./ 

# Set the CMD to the handler
CMD [ "app.handler" ]
```

### Step 5: Build the Docker Image

Build the Docker image using the Dockerfile:

```bash
docker build -t my-lambda-function .
```

### Step 6: Run the Lambda Function with RIE Locally

After building the image, run it using Docker with the RIE:

```bash
docker run -p 9000:8080 my-lambda-function
```

This command starts the Lambda function locally, with RIE emulating the Lambda environment.

### Step 7: Invoke the Lambda Function Locally

You can invoke the function by sending a request to the local endpoint:

```bash
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```

This should return a response from your Lambda function running locally.

By following these steps, you've successfully installed and used the AWS Lambda Runtime Interface Emulator on Ubuntu Linux, allowing you to develop and test AWS Lambda functions locally without needing to deploy them to AWS during development.