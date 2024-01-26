### Prerequisites:

- Download the Splunk Universal Forwarder installer from the official Splunk website.

### Installation Steps:

1. **Run Installer:**
    
    - Double-click the downloaded Splunk Universal Forwarder installer executable.
2. **Welcome Screen:**
    
    - Click "Next" on the welcome screen.
3. **License Agreement:**
    
    - Read and accept the license agreement. Click "Next."
4. **Destination Folder:**
    
    - Choose the installation directory. The default is usually `C:\Program Files\SplunkUniversalForwarder\`. Click "Next."
5. **Data Inputs:**
    
    - Choose which data inputs you want to monitor. For a basic setup, you can leave this as the default. Click "Next."
6. **Configure Event Log Inputs (Optional):**
    
    - If you want to monitor Windows Event Logs, select the logs you're interested in. Click "Next."
7. **Configure Data Outputs:**
    
    - Specify the Splunk indexer(s) where the forwarder should send data. Enter the hostname or IP address and port of your Splunk indexer(s). Click "Next."
8. **Configure Security Settings:**
    
    - Set the username and password for the Splunk Universal Forwarder administrator account. This is used to secure communication between the forwarder and the indexer. Click "Next."
9. **Review Settings:**
    
    - Review your settings. Click "Install" to begin the installation.
10. **Installation Complete:**
    
    - Once the installation is complete, click "Finish."

### Configuration:

1. **Configure Universal Forwarder:**
    
    - Open a command prompt and navigate to the Splunk Universal Forwarder installation directory, e.g., `C:\Program Files\SplunkUniversalForwarder\bin`.
    - Run the following command to configure the forwarder:
        
        bashCopy code
        
        `splunk cmd splunk enable boot-start -user <your_username>`
        
2. **Start Splunk Universal Forwarder:**
    
    - Start the Splunk Universal Forwarder service using the following command:
        
        bashCopy code
        
        `net start SplunkForwarder`
        

### Verify Installation:

1. **Check Splunk Web:**
    
    - Open a web browser and go to `http://localhost:8000` (replace `localhost` with the actual hostname or IP address of your machine). Log in with the admin credentials you set during installation.
    - Check if the Splunk Universal Forwarder appears in the "Forwarder Management" page.
2. **Review Logs:**
    
    - Check the logs in the Splunk Universal Forwarder installation directory (`C:\Program Files\SplunkUniversalForwarder\var\log\splunk\`).

Now, your Splunk Universal Forwarder should be set up on the Windows machine and forwarding data to your Splunk indexer. Adjust configurations based on your specific needs and security requirements.
