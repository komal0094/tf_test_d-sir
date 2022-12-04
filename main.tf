provider "aws" {
  region     = "us-east-1"
   }


terraform {
  cloud {
    organization = "komal0094"

    workspaces {
      name = "first_tf-statefile-manage"
    }
  }
}
#test
# my new branch test
//module nw
//////
module "nw" {
  source = "./modules/nw"
  pub-snets = var.pub-net 
 
  }
   //sg lb
   module "sg" {
   source     = "./modules/sg"
   sg_details = var.sg-info
    vpc-id = module.nw.vpc-id
   }


//ec2 module call
module "ec2" {
  source = "./modules/ec2"
  ec2-sub = {
    test-ec2 = {
         pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-1", null)
         webname = "server1"
      }
    #   test1-ec2 = {
    #      pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-2", null)
    #      webname = "server2"
    #   },
    #   test2-ec2 = {
    #      pub-snet = lookup(module.nw.pub-snet-id, "pub-sub-3", null)
    #      webname = "server3"
    #   }
  
}
   sg = lookup(module.sg.output-sg, "ec2-sg", null)
  ami = var.ami-new
  insta-type = var.instance-type
  key_name = var.key-pair
}


//route 53 module
module "route53" {
  source = "./modules/route53"
  vpc-id = module.nw.vpc-id
  record = {
    rec = {
      record-id = lookup(module.ec2.ec2-pri-ip, "ec2-sub", null)
    }
}
}


