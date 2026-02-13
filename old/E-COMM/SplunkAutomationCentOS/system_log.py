import socket
import json
import subprocess
from datetime import datetime

SPLUNK_SERVER_IP = "SplunkServerIp"
SPLUNK_SERVER_PORT = 000 # The TCP Port configured
LOG_TYPE = "System"
TIMEOUT = 10
MAX_RETRIES = 5

def get_system_logs():
    try:
        logs = subprocess.check_output(['dmesg'], universal_newlines=True)
        return logs.splitlines()
    except Exception as e:
        print(f"Error reading system logs: {e}")
        return []

def send_to_splunk(log_entry):
    retries = 0
    while retries < MAX_RETRIES:
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
                sock.settimeout(TIMEOUT)
                sock.connect((SPLUNK_SERVER_IP, SPLUNK_SERVER_PORT))
                sock.sendall(json.dumps(log_entry).encode('utf-8'))
            print(f"Sent log to Splunk: {log_entry}")
            return
        except Exception as e:
            print(f"Error sending log to Splunk: {e}. Retrying... ({retries + 1}/{MAX_RETRIES})")
            retries += 1

def process_logs():
    logs = get_system_logs()
    for log in logs:
        log_entry = {
            "LogType": LOG_TYPE,
            "TimeGenerated": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "Message": log
        }
        send_to_splunk(log_entry)

if __name__ == "__main__":
    process_logs()
