import subprocess
import time

def run_scripts():
    scripts = ["application_log.py", "security_log.py", "system_log.py"]
    
    while True:
        for script in scripts:
            if script == "security_log.py":
                subprocess.run(["sudo", "python3", script])  # Run with sudo
            else:
                subprocess.run(["python3", script])
        print("All scripts executed. Waiting for the next interval...")
        time.sleep(60)  # Adjust interval as needed

if __name__ == "__main__":
    run_scripts()
