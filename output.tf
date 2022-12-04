output "ec2-id" {
    value = module.ec2.ec2-pub-ip
  }

  output "ec2-pri-id" {
    value = module.ec2.ec2-pri-ip
  }