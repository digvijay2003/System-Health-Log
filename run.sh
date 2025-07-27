#!/bin/bash

# This is the main script to start your system monitoring application.
# It navigates to the 'scripts' directory, runs the monitor and alert scripts once,
# and then launches the interactive menu for ongoing management.

# --- Setup ---

# Change the current directory to 'scripts'.
# This is crucial because your monitor.sh, alert.sh, and menu.sh scripts
# are located inside the 'scripts' folder, and they might rely on relative paths
# (like '../logs/system_health.log' in monitor.sh).
cd scripts

# --- Initial Health Check & Alert ---

# Execute the 'monitor.sh' script once.
# This records the current system health metrics into the log file.
bash monitor.sh

# Execute the 'alert.sh' script once.
# This checks the current system health metrics against defined thresholds
# and sends an email alert if any issues are detected.
bash alert.sh

# --- Launch Interactive Menu ---

# Execute the 'menu.sh' script.
# This starts the interactive command-line interface, allowing you to:
# - View current system status
# - View log history
# - Manually run health checks
# - Exit the application
bash menu.sh
