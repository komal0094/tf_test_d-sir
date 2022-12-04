output "ec2-id" {
    value = {for k, v in aws_instance.dev-ec2: k => v.id}
  
}
output "ec2-pub-ip" {
 value = {for k, v in aws_instance.dev-ec2: k => v.public_ip}
  
}
output "ec2-pri-ip" {
   value = {for k, v in aws_instance.dev-ec2: k => v.private_ip}
  
}