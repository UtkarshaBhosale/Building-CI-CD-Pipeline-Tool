# 🔄 CI/CD Pipeline with Bash, Python & Cron

## 📘 Project Description

This project automates the deployment of a simple web application using a CI/CD pipeline built with Bash, Python, and Cron jobs. It:

* Pulls the latest code from GitHub to an AWS EC2 instance.
* Deploys the code using Nginx.
* Automates tasks like checking for new commits and restarting the server if needed.

The goal is to streamline the deployment process, ensuring your application stays up-to-date with minimal manual effort.

---

## 📑 Table of Contents

* [Prerequisites](#-prerequisites)
* [Installation Instructions](#-installation-instructions)
* [Usage Instructions](#-usage-instructions)
* [Configuration](#-configuration)
* [Security Best Practices](#-security-best-practices)
* [Troubleshooting](#-troubleshooting)
* [Contribution Guidelines](#-contribution-guidelines)
* [License](#-license)

---

## ✅ Prerequisites

* GitHub account and a repository with HTML files
* AWS EC2 (Ubuntu 24.04 LTS) or any Linux VM
* Python 3
* Git
* Nginx installed and running
* GitHub Personal Access Token (for API access)

---

## ☁️ AWS EC2 Setup with Nginx

You’ll need a Linux server to host your application. In this guide, we use an AWS EC2 instance.

### 👥 EC2 Instance Configuration

* **Instance Name & Tags:**
  `utkarsha-ci-cd` — For easy identification in your AWS environment.

* **AMI Selection:**
  Ubuntu Server 24.04 LTS  
  AMI ID: `ami-0e35ddab05955cf57`  
  Default user: `ubuntu`

* **Instance Type:**
  `t2.micro` — Free Tier eligible, perfect for small applications or testing environments.

* **Key Pair:**
  Name: 'utkasrha-key-pair'  
  Make sure to save the `.pem` file securely for SSH access.

* **Network Settings:**

  * **VPC/Subnet:** Default VPC/Subnet
  * **Public IP:** Enabled for remote access
  * **Security Group:** `  
    * **Inbound Rules:**
      * SSH (port 22)
      * HTTP (port 80)
* **Storage:**
  8 GiB — gp3 SSD storage (Free Tier eligible), sufficient for small to medium applications.

* **Launch:**

  * Click **Launch Instance** after reviewing the configuration.


> After launching, replace `<public-ip>` with your EC2's actual IP address.

![EC2 Launch - Step 1](https://github.com/user-attachments/assets/5fb61efb-7ae8-41bb-8590-2f3f088121b6)
![EC2 Launch - Step 2](https://github.com/user-attachments/assets/6f328f6e-22b9-4302-98ae-c29cf6f00132)
![EC2 Launch - Step 3](https://github.com/user-attachments/assets/4c464f4b-1a5f-4b48-9b5a-583e5518b988)

---

## 🔧 Connect to EC2 via SSH

```bash
ssh -i /path/to/utkasrha-key-pair.pem ubuntu@<public-ip>
```

---

### 🛠️ Install Nginx on EC2

```bash
sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

Visit `http://<public-ip>/` in your browser to confirm Nginx is running.

---

## ⚙️ Installation Instructions

```bash
sudo apt update
sudo apt install nginx git python3-pip -y
sudo systemctl enable nginx
sudo systemctl start nginx
```

Clone your GitHub repository:

```bash
git clone https://github.com/your-username/your-repo.git
```

---

## 🚀 Usage Instructions

1. Place your HTML files in a folder like `html/`

2. Create `check_github.py` to detect new commits

3. Create `deploy.sh` to copy files to `/var/www/html`

4. Make the wrapper script executable:

   ```bash
   chmod +x ci_cd_wrapper.sh
   ```

5. Run the Python script to test:

   ```bash
   python3 check_github.py
   ```

---

## ⚙️ Configuration

In `check_github.py`:

```python
REPO = "username/repo-name"
BRANCH = "main"
TOKEN = "your_github_token"
LAST_COMMIT_FILE = "/var/www/Building-CI-CD-Pipeline-Tool/last_commit.txt"
```

In `deploy.sh` or `ci_cd_wrapper.sh`:

```bash
REPO_URL="https://github.com/username/repo-name.git"
DEPLOY_DIR="/var/www/html"
```

Set up a cron job to automate checks:

```bash
crontab -e
```

Add the following to run every 5 minutes:

```cron
*/5 * * * * /usr/bin/bash /var/www/Building-CI-CD-Pipeline-Tool/ci_cd_wrapper.sh >> /var/log/ci_cd_pipeline.log 2>&1
```

---

## 🔐 Security Best Practices

* Store your GitHub token in environment variables or a secrets manager
* Use `repo:read` scope only
* Assign minimal IAM permissions to your EC2 instance

---

## 🛠️ Troubleshooting

| Issue                        | Solution                                     |
| ---------------------------- | -------------------------------------------- |
| Changes not reflecting       | Check Nginx logs and validate file paths     |
| Python script not triggering | Check cron logs: `grep CRON /var/log/syslog` |
| Permission errors            | Use `sudo` or fix ownership (`chown`)        |

---

## 🤝 Contribution Guidelines

Pull requests are welcome. For major changes, please open an issue to discuss your proposal first.

---

## 📄 License

This project is licensed under the MIT License.

---


