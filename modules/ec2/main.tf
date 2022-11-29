resource "aws_instance" "dev-ec2" {
  for_each = var.ec2-sub
   ami           = var.ami
  instance_type = var.insta-type
  key_name = var.key_name
   subnet_id = each.value["pub-snet"]
   security_groups = [var.sg]
   user_data = <<-EOF
#!/bin/bash
apt update -y
apt install nginx -y
systemctl start nginx.service
apt install mysql-sever -y 
apt install php-fpm php-mysql -y
apt install docker.io
EOF

tags = {
    Name = "test-ec2-${each.value["pub-snet"]}"
    env = terraform.workspace
  }
}