#!/bin/bash
# Automates the installation of the Splunk Universal Forwarder. Currently set to v10.0.1. I'm not sure if the link will be valid during the entire CCDC season
# with how much is still left to go. If the download gives you any trouble, create a Splunk account, go to the universal forwarder downloads, pick the one you want,
# then extract the random set of characters found in the link. In this script, these are stored in the variable "SPLUNK_BUILD".
#
# Please note that no monitors, besides a sample test one, are included. My team is using some custom tooling we'd like to keep private for now, and I want to encourage
# people to learn at least a little bit of Splunk to make use of this script. My only request for using this script is that if you ever make any improvements, please share
# them with the community. This will not be enforced with a license.
#
#
# This was put together as an amalgamation of code from my own work, other automatic installation scripts, and lots of tears.
# Lots time went into this script. Be nice to it plz <3
#
# Samuel Brucker 2024-2026
#

# Define Splunk Forwarder variables
SPLUNK_VERSION="10.0.1"
SPLUNK_BUILD="c486717c322b"
SPLUNK_PACKAGE_TGZ="splunkforwarder-${SPLUNK_VERSION}-${SPLUNK_BUILD}-linux-amd64.tgz"
SPLUNK_DOWNLOAD_URL="https://download.splunk.com/products/universalforwarder/releases/${SPLUNK_VERSION}/linux/${SPLUNK_PACKAGE_TGZ}"
INSTALL_DIR="/opt/splunkforwarder"


# Set defaults for configuration
DEFAULT_INDEXER_IP="172.20.242.20"
DEFAULT_ADMIN_USERNAME="admin"
DEFAULT_ADMIN_PASSWORD="YouShouldProbablyChangeThis"  # Replace with a secure password

# Override defaults with command-line arguments if they are provided
# Usage: ./script.sh [indexer_ip] [username] [password]
INDEXER_IP=${1:-$DEFAULT_INDEXER_IP}
ADMIN_USERNAME=${2:-$DEFAULT_ADMIN_USERNAME}
ADMIN_PASSWORD=${3:-$DEFAULT_ADMIN_PASSWORD}

# Pretty colors :)
RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
YELLOW=$'\e[0;33m'
BLUE=$'\e[0;34m'
NC=$'\e[0m'  #No Color - resets the color back to default

# Function to check for required command dependencies
install_dependencies() {
  echo "${BLUE}Checking for required dependencies...${NC}"

  # Detect Package Manager
  local PKG_MANAGER=""

  if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
  elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
  elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
  else
    echo "${RED}Error: No supported package manager (apt-get, dnf, yum) found. Aborting.${NC}"
    exit 1
  fi

  echo "${GREEN}Using package manager: $PKG_MANAGER${NC}"

  local all_deps_installed=true

  # List of commands to check
  local required_cmds=("wget" "tar" "setfacl")

  for cmd in "${required_cmds[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
      echo "${YELLOW}Dependency '$cmd' is missing. Attempting installation...${NC}"

      local package_name=""
      case "$cmd" in
        wget)
          package_name="wget"
          ;;
        tar)
          package_name="tar"
          ;;
        setfacl)
          package_name="acl"
          ;;
      esac

      if [ -n "$package_name" ]; then
        # Run install non-interactively
        if [ "$PKG_MANAGER" == "apt-get" ]; then
            sudo DEBIAN_FRONTEND=noninteractive $PKG_MANAGER install -y "$package_name"
        else
            sudo $PKG_MANAGER install -y "$package_name"
        fi

        if [ $? -ne 0 ]; then
            echo "${RED}Failed to install package '$package_name' for command '$cmd'.${NC}"
            all_deps_installed=false
        fi
      else
         echo "${RED}Don't know which package provides '$cmd' for this system.${NC}"
         all_deps_installed=false
      fi

      # Re-check
      if ! command -v "$cmd" &> /dev/null; then
         echo "${RED}Error: Command '$cmd' is still not found after installation attempt.${NC}"
         all_deps_installed=false
      fi

    else
      echo "${GREEN}Dependency '$cmd' is already installed.${NC}"
    fi
  done

  if [ "$all_deps_installed" = false ]; then
    echo "${RED}One or more required dependencies could not be installed. Please install them manually and run the script again.${NC}"
    exit 1
  fi

  echo "${GREEN}All dependencies are satisfied.${NC}"
}

# --- SCRIPT EXECUTION STARTS HERE ---

# Install any missing dependencies
install_dependencies


# Announce the configuration that will be used
echo "${BLUE}--- Splunk Forwarder Configuration ---${NC}"
echo "${GREEN}Indexer IP:      ${NC}$INDEXER_IP"
echo "${GREEN}Admin Username:  ${NC}$ADMIN_USERNAME"
echo "${GREEN}Admin Password:  ${NC}(hidden)"
echo "${BLUE}------------------------------------${NC}"

# Make sure this is being run as root or sudo
if [[ $EUID -ne 0 ]]; then
    echo "${RED}This script must be run as root or with sudo.${NC}"
    exit 1
fi

# IDEMPOTENCY CHECK: Exit if Splunk is already installed
if [ -d "$INSTALL_DIR" ]; then
  echo "${YELLOW}Splunk Universal Forwarder is already installed in $INSTALL_DIR. Aborting installation.${NC}"
  exit 0
fi

# Check the OS and install the necessary package
if [ -f /etc/os-release ]; then
  . /etc/os-release
else
  echo "${RED}Unable to detect the operating system. Aborting.${NC}"
  exit 1
fi

# Output detected OS
echo "${GREEN}Detected OS ID: $ID ${NC}"

# Function to create the Splunk user and group
create_splunk_user() {
  if ! id -u splunk &>/dev/null; then
    echo "${BLUE}Creating splunk user and group...${NC}"
    sudo groupadd splunk
    sudo useradd -r -g splunk -d $INSTALL_DIR splunk
  else
    echo "${GREEN}Splunk user already exists.${NC}"
  fi
}

# Function to install Splunk Forwarder
install_splunk() {
  local max_retries=3
  local retry_count=0
  local download_success=false

  echo "${BLUE}Downloading Splunk Forwarder tarball...${NC}"

  while [ $retry_count -lt $max_retries ] && [ $download_success = false ]; do
    if [ $retry_count -eq 0 ]; then
      # First attempt: Try with certificate verification
      wget -O $SPLUNK_PACKAGE_TGZ $SPLUNK_DOWNLOAD_URL
      local status=$?
    else
      # Subsequent attempts: Try without certificate verification
      echo "${YELLOW}Certificate verification failed, attempting download without certificate check...${NC}"
      wget --no-check-certificate -O $SPLUNK_PACKAGE_TGZ $SPLUNK_DOWNLOAD_URL
      local status=$?
    fi

    if [ $status -eq 0 ]; then
      download_success=true
    else
      retry_count=$((retry_count + 1))
      echo "${RED}Download failed (attempt $retry_count/$max_retries). Retrying in 5 seconds...${NC}"
      sleep 5
    fi
  done

  if [ $download_success = false ]; then
    echo "${RED}All download attempts failed. Aborting installation.${NC}"
    return 1
  fi

  echo "${BLUE}Extracting Splunk Forwarder tarball...${NC}"
  sudo tar -xvzf $SPLUNK_PACKAGE_TGZ -C /opt
  rm -f $SPLUNK_PACKAGE_TGZ

  echo "${BLUE}Setting permissions...${NC}"
  create_splunk_user
  sudo chown -R splunk:splunk $INSTALL_DIR
}


# Function to set admin credentials
set_admin_credentials() {
  echo "${BLUE}Setting admin credentials...${NC}"
  USER_SEED_FILE="$INSTALL_DIR/etc/system/local/user-seed.conf"
  sudo bash -c "cat > $USER_SEED_FILE" <<EOL
[user_info]
USERNAME = $ADMIN_USERNAME
PASSWORD = $ADMIN_PASSWORD
EOL
  sudo chown splunk:splunk $USER_SEED_FILE
  echo "${GREEN}Admin credentials set.${NC}"
}

# Function to set up a consolidated set of monitors
setup_monitors() {
  echo "${BLUE}Setting up consolidated monitors...${NC}"
  MONITOR_CONFIG="$INSTALL_DIR/etc/system/local/inputs.conf"

  # Consolidated list of monitors. Splunk will gracefully ignore files that do not exist on the host.
  MONITORS="
#Test log
[monitor://var/log]
index = main
sourcetype = test
"

  # Write the configuration
  sudo bash -c "cat > $MONITOR_CONFIG" <<EOL
$MONITORS
EOL

  sudo chown splunk:splunk $MONITOR_CONFIG
  echo "${GREEN}Monitors configured.${NC}"
}

# Function to configure the forwarder to send logs to the Splunk indexer
configure_forwarder() {
  echo "${BLUE}Configuring Splunk Universal Forwarder to send logs to $INDEXER_IP:9997...${NC}"
  sudo $INSTALL_DIR/bin/splunk add forward-server $INDEXER_IP:9997 -auth $ADMIN_USERNAME:$ADMIN_PASSWORD
  echo "${GREEN}Forward-server configuration complete.${NC}"
}

# SIMPLIFIED: Function to restart Splunk using systemd
restart_splunk() {
  echo "${BLUE}Restarting Splunk Forwarder via systemd...${NC}"
  if sudo systemctl restart SplunkForwarder; then
    echo "${GREEN}Splunk Forwarder successfully restarted.${NC}"
    return 0
  else
    echo "${RED}Failed to restart Splunk. Please check logs for errors.${NC}"
    sudo systemctl status SplunkForwarder --no-pager # Show status on failure
    return 1
  fi
}

# --- Main Installation Logic ---

# Perform installation
install_splunk

# Set admin credentials before starting the service
set_admin_credentials

# Enable Splunk service and accept license agreement
if [ -d "$INSTALL_DIR/bin" ]; then
  echo "${BLUE}Starting and enabling Splunk Universal Forwarder service...${NC}"
  sudo $INSTALL_DIR/bin/splunk start --accept-license --answer-yes --no-prompt
  sudo $INSTALL_DIR/bin/splunk enable boot-start

  # Add monitors
  setup_monitors

  # Configure forwarder to send logs to the Splunk indexer
  configure_forwarder

  # Restart Splunk using our new function
  if ! restart_splunk; then
    echo "${RED}Splunk Forwarder restart failed. Installation incomplete.${NC}"
    exit 1
  fi
else
  echo "${RED}Installation directory not found. Something went wrong.${NC}"
  exit 1
fi

#Create test log
echo "${BLUE}Creating test log. ${NC}"
echo "Test log entry" > /tmp/test.log
sudo setfacl -m u:splunk:r /tmp/test.log

# Verify installation
sudo $INSTALL_DIR/bin/splunk version

echo "${YELLOW}Splunk Universal Forwarder v$SPLUNK_VERSION installation complete with monitors and forwarder configuration!${NC}"
