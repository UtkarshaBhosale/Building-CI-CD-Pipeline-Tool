# 🔄 Simple CI/CD Pipeline with Bash, Python & Cron

## 📘 Project Description

This project automates the deployment of a simple web application using a CI/CD pipeline. The pipeline is built with Bash, Python, and Cron jobs to:

- Push the latest code from GitHub to an AWS EC2 instance.
- Deploy the code using Nginx.
- Automate tasks like checking for new commits and restarting the server.

The goal is to streamline the deployment process, ensuring the application stays up-to-date with minimal manual intervention.

---

## 📑 Table of Contents

- [Prerequisites](#prerequisites)  
- [Installation Instructions](#installation-instructions)  
- [Usage Instructions](#usage-instructions)  
- [Configuration](#configuration)  
- [Output](#output)  
- [Security Best Practices](#security-best-practices)  
- [Troubleshooting](#troubleshooting)  
- [Contribution Guidelines](#contribution-guidelines)  
- [License](#license)  

---

## ✅ Prerequisites

- GitHub Account and Repository with HTML files  
- AWS EC2 or any Linux VM  
- Python 3  
- Git  
- Nginx installed and running  
- GitHub Personal Access Token (for API access)

---

### AWS EC2 Setup with Nginx

To host your CI/CD-managed application, you will need a Linux server where Nginx will act as the web server to serve your deployed files. We'll use an AWS EC2 instance running **Ubuntu 24.04 LTS** for this setup.

#### 👥 EC2 Instance Configuration

* **Instance Name & Tags:**
  `utkarsha-ci-cd` — For easy identification in your AWS environment.

* **AMI Selection:**
  Ubuntu Server 24.04 LTS  
  AMI ID: `ami-0e35ddab05955cf57`  
  Default user: `ubuntu`

* **Instance Type:**
  `t2.micro` — Free Tier eligible

* **Key Pair:**
  Name: 'utkasrha-key-pair'

* **Network Settings:**
  * VPC/Subnet: Default
  * Public IP: Enabled
  * Security Group: Allow SSH (22) and HTTP (80)

* **Storage:**
  8 GiB — gp3 SSD

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

Then open `http://<public-ip>/` in a browser to verify.

---

## ⚙️ Installation Instructions

```bash
sudo apt update
sudo apt install nginx git python3-pip -y
sudo systemctl start nginx
sudo systemctl enable nginx
git clone https://github.com/your-username/your-repo.git
```

---

## 🚀 Usage Instructions

1. Place your HTML files in a folder like `html`
2. Create and configure `check_github.py`
3. Create `deploy.sh` to copy files to `/var/www/html`
4. Make scripts executable:

```bash
chmod +x ci_cd_wrapper.sh
```

5. Run Python script manually to test:

```bash
python3 check_github.py
```

---

## ⚙️ Configuration

Update these values in `check_github.py`:

```python
REPO = "username/repo-name"
BRANCH = "main"
TOKEN = "your_github_token"
LAST_COMMIT_FILE = "/var/www/Building-CI-CD-Pipeline-Tool/last_commit.txt"
```

Update paths in `ci_cd_wrapper.sh`:

```bash
REPO_URL="https://github.com/username/repo-name.git"
DEPLOY_DIR="/var/www/html"
```

Set up the cron job:

```bash
crontab -e
```

Add:

```cron
*/5 * * * * /usr/bin/bash /var/www/Building-CI-CD-Pipeline-Tool/ci_cd_wrapper.sh >> /var/log/ci_cd_pipeline.log 2>&1
```

---

## 📤 Output

### 📝 1. Logs in `/var/log/ci_cd_pipeline.log`

![image](https://github.com/user-attachments/assets/bd60dbd4-445b-4501-a882-f9e8b977c937)

### 🌐 2. Web Application Updated on EC2 Public IP

Check your site at:

```
http://<your-ec2-public-ip>/
```

✔️ Refreshing the page reflects the newest GitHub code.

---

### 🗂️ 3. Commit Tracking

```bash
cat /var/www/Building-CI-CD-Pipeline-Tool/last_commit.txt
```
![image](https://github.com/user-attachments/assets/4d1813a6-aab3-428d-972d-9fde5ea6399c)


---

## 🔐 Security Best Practices

- Store GitHub token securely
- Use limited scope (`repo:read`)
- Apply least privilege on EC2

---

## 🛠️ Troubleshooting

| Issue                        | Solution                                      |
| ---------------------------- | --------------------------------------------- |
| Changes not reflecting       | Check Nginx logs and HTML copy path           |
| Python script not triggering | Check cron logs `grep CRON /var/log/syslog`   |
| Permission denied errors     | Use `sudo` or adjust file ownership           |

---

## 🤝 Contribution Guidelines

Pull requests are welcome. Open an issue to discuss changes.

---

## 📄 License

This project is licensed under the MIT License.
