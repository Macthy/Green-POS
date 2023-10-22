#!/bin/bash

# Update the system and install essential packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y curl wget git build-essential

# Install and configure Git
sudo apt install -y git
git config --global user.name "Macthy"
git config --global user.email "thywilberdonemacharia@gmail.com"

# Install Node.js using the NodeSource repository
# Fetch the latest LTS (Long Term Support) version based on your Ubuntu release
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y

# Install npm packages localy (example packages, customize as needed)
sudo npm install pm2 nodemon eslint typescript mocha yarn

# Install other useful development tools and libraries
sudo apt-get install -y software-properties-common python3-pip

# Set up SSH and authorized keys
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Read the public key from the file
YOUR_PUBLIC_KEY=$(cat my_public_key.pub)

# Add your SSH public key to the authorized keys file (replace 'YOUR_PUBLIC_KEY' with your actual public key)
echo "$YOUR_PUBLIC_KEY" >> ~/.ssh/authorized_keys

# Secure SSH by modifying SSH daemon configuration
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# Additional resources and utilities you may need
# Example: Install Docker
# sudo apt-get install -y docker.io

# Example: Install PostgreSQL
# sudo apt-get install -y postgresql postgresql-contrib

# Example: Install Redis
# sudo apt-get install -y redis-server

# Example: Install Nginx
# sudo apt-get install -y nginx

# Example: Install Certbot for Let's Encrypt SSL certificates
# sudo apt-get install -y certbot python3-certbot-nginx

# Optional: Set up a firewall (e.g., UFW) and allow necessary ports
# Example: sudo ufw allow OpenSSH
# Example: sudo ufw allow 80/tcp
# Example: sudo ufw allow 443/tcp
# sudo ufw enable

# Optional: Configure Nginx or other web server if needed

# Finish with any other specific configurations or software installations you require

echo "Setup complete. Remember to configure your firewall and any additional services as needed."
