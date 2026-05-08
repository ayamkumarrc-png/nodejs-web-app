#! /bin/bash

sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Create startup script
cat << EOT > start-website
/bin/sh -e -c 'echo $(aws ecr get-login-password --region us-east-1) | docker login -u AWS --password-stdin ${repository_url}'
sudo docker pull ${repository_url}:release
sudo docker run -p 80:8000 ${repository_url}:release
EOT

# Move startup script
sudo mv start-website /var/lib/cloud/scripts/per-boot/start-website

# Make executable
sudo chmod +x /var/lib/cloud/scripts/per-boot/start-website

# Run script
/var/lib/cloud/scripts/per-boot/start-website#! /bin/bash
echo "Hello Application Server" >> /home/ec2-user/application_rc.txt
