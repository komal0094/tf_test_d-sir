variable "ami" {
  
}
variable "insta-type" {
    }

variable "sg" {
  }

variable "key_name" {
    }

variable "ec2-sub" {
   type = map(object({
    pub-snet = string
    webname = string
   })) 
}
