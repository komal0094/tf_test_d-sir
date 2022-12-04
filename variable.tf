

//nw module varibale
variable "pub-net" {
 description = "public sunbet of vpc" 
}

//sg variable
variable "sg-info" {
  description = "sg-port allow for security"
}
//ec2 variable

variable "ami-new" {
  type = string
  description = "ami id for ec2"
#   default = "ami-052efd3df9dad4825"

 validation {
    # condition     = length(var.ami-new) > 4 && substr(var.ami-new, 0, 4) == "ami-"
     condition = can(regex("^ami-[0-9A-Za-z]+$", var.ami-new))
    #  condition = can(regex("^[A-Za-z0-9_-]", var.ami-new))
# condition     = can(regex("[^[:alnum:]]", var.ami-new))
   error_message = "Please provide a valid value for AMI."
 }
}
variable "instance-type" {
    description = "instance type for aws ec2"
  }
 variable "key-pair" {
    description = "key-pair for ec2 authentication for ssh"
 }