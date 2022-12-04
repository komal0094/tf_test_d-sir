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
hostnamectl set-hostname ${each.value["webname"]}
apt install nginx -y
systemctl start nginx.service
apt install docker.io -y
EOF

tags = {
    Name = "test-ec2-${each.value["webname"]}"
    env = terraform.workspace
  }
}

//key-name generate
resource "aws_key_pair" "tf_key" {
  key_name   = "tf_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf_key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "tfkey"
}