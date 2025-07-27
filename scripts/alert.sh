#!/bin/bash

# This script checks system resource usage against predefined thresholds
# and sends an email alert if any threshold is exceeded.

# --- Configuration: Alert Thresholds ---

# Set the CPU usage percentage at which an alert should be triggered.
# If CPU usage goes above 70%, an alert will be sent.
THRESHOLD_CPU=70

# Set the Memory usage percentage at which an alert should be triggered.
# If Memory usage goes above 80%, an alert will be sent.
THRESHOLD_MEM=80

# Set the Disk usage percentage at which an alert should be triggered.
# If Disk usage goes above 90%, an alert will be sent.
THRESHOLD_DISK=90

# --- Data Collection ---

# Get the current CPU usage as a whole number (integer).
# - `top -bn1 | grep "Cpu(s)"`: Same as in monitor.sh, gets the CPU line.
# - `awk '{print $2 + $4}'`: Calculates user + system CPU.
# - `cut -d. -f1`: Takes the result (e.g., "1.6") and cuts it at the dot,
#   keeping only the part before the dot ("1"), making it an integer.
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | cut -d. -f1)

# Get the current Memory usage as a whole number (integer percentage).
# - `free | awk '/Mem/ {printf("%d"), $3/$2 * 100}'`: Calculates memory usage percentage
#   and formats it directly as an integer (e.g., 8 instead of 8.44).
MEM=$(free | awk '/Mem/ {printf("%d"), $3/$2 * 100}')

# Get the current Disk usage as a whole number (integer percentage).
# - `df -h / | awk 'NR==2 {print $5}' | tr -d '%'`: Same as in monitor.sh, gets
#   the disk usage percentage and removes the '%' sign.
DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# --- Alert Message Construction ---

# Initialize an empty variable to store the alert message.
# This variable will be populated if any thresholds are crossed.
ALERT_MSG=""

# Check if CPU usage is greater than the CPU threshold.
# If true, add a "High CPU Usage" line to the ALERT_MSG.
[[ $CPU -gt $THRESHOLD_CPU ]] && ALERT_MSG+="High CPU Usage: $CPU%\n"

# Check if Memory usage is greater than the Memory threshold.
# If true, add a "High Memory Usage" line to the ALERT_MSG.
[[ $MEM -gt $THRESHOLD_MEM ]] && ALERT_MSG+="High Memory Usage: $MEM%\n"

# Check if Disk usage is greater than the Disk threshold.
# If true, add a "High Disk Usage" line to the ALERT_MSG.
[[ $DISK -gt $THRESHOLD_DISK ]] && ALERT_MSG+="High Disk Usage: $DISK%\n"

# --- Send Alert (if needed) ---

# Check if the ALERT_MSG variable is not empty (i.e., if any alerts were triggered).
if [[ -n "$ALERT_MSG" ]]; then
    # If there's an alert message, send an email.
    # - `echo -e "..."`: Prints the alert message. `-e` interprets newline characters (`\n`).
    # - `$(hostname)`: Replaced with your computer's name (e.g., "25Digu-Laptop").
    # - `| mail -s "System Health Alert" your@email.com`: Pipes the message
    #   to the 'mail' command, sending an email with the subject "System Health Alert"
    #   to the specified email address. **Remember to change `your@email.com` to your actual email!**
    echo -e "System Alert on $(hostname)\n\n$ALERT_MSG" | mail -s "System Health Alert" digupathania25@gmail.com
fi
