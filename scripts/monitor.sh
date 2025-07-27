#!/bin/bash

# This script monitors key system health metrics (CPU, Memory, Disk)
# and logs them to a specified file.

# --- Configuration ---

# Define the path to the log file where system health data will be recorded.
LOG_FILE="../logs/system_health.log"

# --- Data Collection ---

# Get the current date and time in a specific format (YYYY-MM-DD HH:MM:SS).
# This timestamp will be prepended to each log entry.
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Get the current CPU usage.
# - `top -bn1`: Runs top in batch mode (-b) and exits after one iteration (-n1).
# - `grep "Cpu(s)"`: Filters the output to find the line containing "Cpu(s)".
# - `awk '{print $2 + $4}'`: Extracts the idle CPU percentage ($2) and adds it to the user CPU percentage ($4).
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get the current memory usage as a percentage.
# - `free`: Displays information about free and used memory.
# - `awk '/Mem/ {printf("%.2f"), $3/$2 * 100.0}'`: Finds the line containing "Mem",
#   then calculates the percentage of used memory ($3) out of total memory ($2) and formats it to two decimal places.
MEM=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100.0}')

# Get the current disk usage for the root partition (/).
# - `df -h /`: Displays disk space usage in human-readable format (-h) for the root directory.
# - `awk 'NR==2 {print $5}'`: Selects the fifth field (percentage used) from the second line of output.
# - `tr -d '%'`: Removes the '%' character from the output, leaving only the number.
DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

# --- Logging ---

# Append the collected system health data to the log file.
# The format is "DATE | CPU: XX% | MEM: YY% | DISK: ZZ%".
echo "$DATE | CPU: $CPU% | MEM: $MEM% | DISK: $DISK%" >> "$LOG_FILE"
