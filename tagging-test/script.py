import yaml
import subprocess
import json
import logging
import os

# Setup basic configuration for logging
logging.basicConfig(filename='terraform_apply.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
current_location = '/vagrant/shared/localstack/tagging-test/'

def load_tag_combinations(file_path):
    try:
        with open(os.path.join(current_location, file_path), 'r') as file:
            return yaml.safe_load(file)
    except Exception as e:
        logging.error(f"Failed to load YAML file: {e}")
        return []

def update_tfvars(tags):
    try:
        with open(os.path.join(current_location, 'terraform.tfvars'), 'w') as file:
            content = f'instance_tags = {json.dumps(tags)}'
            file.write(content)
    except Exception as e:
        logging.error(f"Failed to write to tfvars file: {e}")

def execute_terraform():
    try:
        os.chdir(current_location)  
        subprocess.run(['terraform', 'init'], check=True, cwd=current_location)
        result = subprocess.run(['terraform', 'apply', '-auto-approve'], capture_output=True, text=True, check=True, cwd=current_location)
        logging.info(result.stdout)
        if result.stderr:
            logging.error("Terraform apply error: " + result.stderr)
    except subprocess.CalledProcessError as e:
        logging.error(f"Terraform error: {e.stdout} \n {e.stderr}")
    except Exception as e:
        logging.error(f"Error in executing Terraform: {e}")

def main():
    tag_combinations = load_tag_combinations('tags.yaml')
    if not tag_combinations:
        logging.error("No tag combinations loaded. Exiting.")
        return

    for tags in tag_combinations:
        update_tfvars(tags)
        execute_terraform()

if __name__ == "__main__":
    main()


