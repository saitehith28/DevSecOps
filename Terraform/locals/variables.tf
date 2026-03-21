variable "name"{
    type=string
    default="locals"
}
variable "environment" {
    type        = string
    default     = "dev"
}

# variable "instance_name" {
#     type = string
#     default = "${var.name}-${var.environment}" # locals-dev
# }


variable "ec2_tags" {
    default = {
        Name = "locals-demo"
        Environment = "prod"
    }
}

variable "sg_tags" {
    default = {
        Name = "locals-demo"
    }
}