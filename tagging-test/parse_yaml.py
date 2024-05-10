import yaml
import json
import sys

with open('tags.yaml', 'r') as file:
    data = yaml.safe_load(file)
    # Ensure output is a JSON object
    json_output = json.dumps(data['instance_tags'])
    print(json_output)

