import re

log_file_path = 'terraform.log'

# Define a list to hold tuples of timestamp and API actions.
api_calls = []

# Open and read through the log file line by line.
with open(log_file_path, 'r') as file:
    for line in file:
        # Check for the presence of "Action=" which indicates an API call.
        if "Action=" in line:
            # Extract the timestamp (first two split elements represent the date and time).
            timestamp = line.split()[0] + " " + line.split()[1]
            # Use regex to find the Action key and its value.
            action = re.search(r"Action=([^\&]+)", line)  # Adjusted to capture until the next parameter or end of line
            if action:
                # Append the timestamp and action value to the list.
                api_calls.append((timestamp, action.group(1)))

# Print out each found API call with its timestamp and action.
for call in api_calls:
    print(f"Timestamp: {call[0]}, API Action: {call[1]}")


