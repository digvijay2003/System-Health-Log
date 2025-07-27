# System Health Monitor

This project provides a simple yet effective shell-scripting solution to monitor your system's CPU, memory, and disk usage. It logs historical data, sends email alerts for high resource utilization, and offers an interactive menu for easy management.

---

## Features

* **Resource Monitoring:** Tracks CPU, memory, and disk usage.
* **Historical Logging:** Records system health metrics with timestamps in a dedicated log file.
* **Email Alerts:** Notifies you via email if resource usage exceeds predefined thresholds.
* **Interactive Menu:** A user-friendly command-line interface to:
    * View current system status (top processes).
    * Review recent log history.
    * Manually trigger a health check and alert.

---

## Project Structure
```
system-monitor/
├── README.md             <-- This file
├── logs/                 <-- Directory for system health logs
│   └── system_health.log
├── run.sh                <-- Main script to start the monitor
└── scripts/
├── alert.sh          <-- Script for checking thresholds and sending alerts
├── menu.sh           <-- Interactive menu script
└── monitor.sh        <-- Script for collecting and logging system metrics
```

---

## Getting Started

Follow these steps to set up and run the system health monitor on your machine.

### Prerequisites

* A Linux-based operating system (e.g., Ubuntu, Debian, Fedora, CentOS).
* `bash` shell (usually pre-installed).
* `mailx` or `mailutils` package for sending email alerts.

**Install `mailx`/`mailutils` (if not already installed):**

* **On Debian/Ubuntu:**
    ```bash
    sudo apt update
    sudo apt install mailutils
    ```
* **On CentOS/RHEL/Fedora:**
    ```bash
    sudo yum install mailx # or dnf install mailx for newer Fedora
    ```
    *You may need to configure `mailutils` or `mailx` to send emails via an SMTP server (e.g., Postfix, Sendmail, or an external SMTP service like Gmail's SMTP).*

### Installation

1.  **Clone the repository (or download the files):**
    ```bash
    git clone [https://github.com/your-username/system-monitor.git](https://github.com/your-username/system-monitor.git) # Replace with your actual repo URL
    cd system-monitor
    ```
    *If you downloaded the files manually, ensure the directory structure matches the "Project Structure" section above.*

2.  **Make scripts executable:**
    ```bash
    chmod +x run.sh scripts/*.sh
    ```

3.  **Create the logs directory:**
    ```bash
    mkdir -p logs
    touch logs/system_health.log
    ```

### Configuration

Before running, you need to configure the email address for alerts and optionally adjust the monitoring thresholds.

1.  **Edit `scripts/alert.sh`:**
    Open `scripts/alert.sh` in a text editor:
    ```bash
    vi scripts/alert.sh # or use nano, gedit, etc.
    ```
    Find the line:
    ```bash
    echo -e "System Alert on $(hostname)\n\n$ALERT_MSG" | mail -s "System Health Alert" your@email.com
    ```
    **Replace `your@email.com` with your actual email address** where you want to receive alerts.

    You can also adjust the **thresholds** at the top of `alert.sh` if you want different alert levels:
    ```bash
    THRESHOLD_CPU=70
    THRESHOLD_MEM=80
    THRESHOLD_DISK=90
    ```

---

## Usage

To start the system monitor and access its interactive menu:

```bash
./run.sh


