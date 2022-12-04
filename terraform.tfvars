//nw
pub-net= {
pub-sub-1 = {
          availability_zone = "us-east-1a"
        cidr_block = "10.0.0.0/18"
      }
    #   pub-sub-2 = {
    #       availability_zone = "us-east-1b"
    #      cidr_block= "10.0.64.0/18"
    #   },
    #   pub-sub-3 = {
    #       availability_zone = "us-east-1c"
    #      cidr_block= "10.0.128.0/18"
    #   }
}


//sg
sg-info = {
    "ec2-sg" = {
        name = "test1"
        description = "test1"
        # vpc_id = vpc-123456

        ingress_rules = [
             {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                security_groups = null
                self = null
            },
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                security_groups = null
                self = null
            },
            {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                security_groups = null
                self = null
            },
            {

                from_port = 2237
                to_port   = 2237
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
                security_groups = null
                self = null
            }
         ]

  egress = {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    }
   }

   //ec2 
 
ami-new = "ami-052efd3df9dad4825"
instance-type = "t2.micro"
key-pair = "null"//keyname tfkey write here