variable "common_tags"{
    default = {
        Project = "roboshop"
        Terraform = "true"
        Environment = "dev"
    }
}

variable "ec2_tags"{
    default = {
        Name = "functions-demo"
        Environment = "prod"
    }
}

variable "sg_rules"{
    default = {
        Name = "functions-demo"
    }
}