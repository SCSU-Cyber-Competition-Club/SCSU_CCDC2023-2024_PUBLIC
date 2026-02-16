#!/bin/bash

#NEED TO TEST THIS!!!!

# Define threshold value
THRESHOLD=10

# Function to count active connections on a given port
count_connections() {
    local port=$1
    netstat -an | grep ":$port" | grep ESTABLISHED | wc -l
}

# Function to send an alert
send_alert() {
    local port=$1
    local count=$2
    echo "ALERT: Port $port has $count active connections, exceeding threshold of $THRESHOLD!"
    # Uncomment the next line to send an email alert (requires mailutils or sendmail configured)
    # echo "High traffic on port $port: $count connections" | mail -s "Port Alert: $port" admin@example.com
}

# Monitor ports
while true; do
    for port in 80 22; do
        count=$(count_connections $port)
        if [ "$count" -ge "$THRESHOLD" ]; then
            send_alert $port $count
        else
            echo "Port $port is within safe limits ($count connections)."
        fi
    done
    sleep 10  # Adjust polling interval as needed
done
