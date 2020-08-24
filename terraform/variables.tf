variable "AWS_REGION" {
    default = "eu-west-1"
}


variable "availability_zone" {
    default = "eu-west-1a"
}
# AMI ID's
variable "App_AMI" {
    type = "string"
    default = "ami-047f3d9ded73526e1"
}

variable "DB_AMI" {
    type = "string"
    default = "ami-03bf944ca6b1a8075"
}

variable "Bastion_AMI" {
    type = "string"
    default = "ami-010bee17f9b292a67"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}
# SG ID's
variable "App_sg" {
    type = string
    default = "sg-0f7450f404e4f3bc3"
}


variable "DB_sg" {
    type = string
    default = "sg-0f30906b845e4ad4e"
}

variable "Bastion_sg" {
    type = string
    default = "sg-051affa55c78f12f7"
}




















