provider "aws" {
  region     = "us-east-1"
   }

#test
# my new branch test
//module nw
//////
module "nw" {
  source = "./modules/nw"
  pub-snets = {
    pub-sub-1 = {
          availability_zone = "us-east-1a"
        cidr_block = "10.0.0.0/18"
      },
      pub-sub-2 = {
          availability_zone = "us-east-1b"
         cidr_block= "10.0.64.0/18"
      },
      pub-sub-3 = {
          availability_zone = "us-east-1c"
         cidr_block= "10.0.128.0/18"
      }
  }
}
   //sg lb
   module "sg" {
   source     = "./modules/sg"
   sg_details = {
    "ec2-sg" = {
        name = "test1"
        description = "test1"
        vpc_id = module.nw.vpc_id

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

                from_port = 443
                to_port   = 443
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
   }


//ec2 module call
module "ec2" {
  source = "./modules/ec2"
  ec2-sub = {
    test-ec2 = {
         pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-1", null)
         webname = "server1"
      },
      test1-ec2 = {
         pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-2", null)
         webname = "server2"
      },
      test2-ec2 = {
         pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-3", null)
         webname = "server3"
      }
  }
  sg = lookup(module.sg.output-sg, "ec2-sg", null)
  ami = "ami-052efd3df9dad4825"
  insta-type = "t2.micro"
  key_name = "key001"
}