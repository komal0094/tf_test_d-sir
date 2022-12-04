//route 53 hosted zone

resource "aws_route53_zone" "my-test-zone" {
  name = "test.com"
  vpc{
  vpc_id = var.vpc-id
  }
  tags = {
    Name = "${terraform.workspace}-route53"
    env = terraform.workspace
  }
}

//route 53 record
resource "aws_route53_record" "record1" {
  zone_id = aws_route53_zone.my-test-zone.zone_id
  name    = "server1.com"
  type    = "A"
  ttl     = 300
#   records = [for v in var.record : v.record-id]
records = [var.record1]
}