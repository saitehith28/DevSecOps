module "sg"{
    source="git::https://github.com/saitehith28/Terraform-Modules.git//terraform-aws-sg?ref=main"
    project=var.project
    environment=var.environment
    sg_name=replace(var.sg_names[count.index],"_","-")
    vpc_id=local.vpc_id
}