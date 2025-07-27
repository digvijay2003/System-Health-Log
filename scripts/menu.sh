#!/bin/bash

# This script provides an interactive menu for viewing system status,
# checking logs, and manually running health checks.

# Start an infinite loop, so the menu keeps showing until the user chooses to exit.
while true; do
    # --- Display Menu Options ---
    echo "===== System Monitor Menu ====="
    echo "1. View Current System Status" # Shows a quick summary of what's happening now
    echo "2. View Log History"         # Shows recent entries from the system health log
    echo "3. Run Health Check Now"     # Manually runs the monitor and alert scripts
    echo "4. Exit"                     # Quits the menu

    # Prompt the user to choose an option and store their input in the 'opt' variable.
    read -p "Choose an option: " opt

    # --- Process User's Choice ---
    # 'case' statement checks the value of 'opt' and runs the corresponding commands.
    case $opt in
        # If the user enters '1':
        1)
            # Show the top 5 lines of the 'top' command output.
            # This gives a quick overview of running processes and system load.
            top -bn1 | head -n 5
            echo "" # Print an empty line for better readability
            ;; # End of option 1

        # If the user enters '2':
        2)
            # Show the last 10 entries from the system health log file.
            # This allows viewing recent monitoring history.
            tail -n 10 ../logs/system_health.log
            echo "" # Print an empty line for better readability
            ;; # End of option 2

        # If the user enters '3':
        3)
            # Manually run the `monitor.sh` script to collect and log data.
            bash ./monitor.sh
            # Manually run the `alert.sh` script to check for alerts and send emails.
            bash ./alert.sh
            echo "Manual health check completed." # Inform the user
            ;; # End of option 3

        # If the user enters '4':
        4)
            echo "Exiting." # Inform the user that the script is ending
            break          # Exit the 'while true' loop, terminating the script
            ;; # End of option 4

        # If the user enters anything else (not 1, 2, 3, or 4):
        *)
            echo "Invalid option" # Tell the user their input was not valid
            ;; # End of default case
    esac # End of case statement
done # End of while loop
