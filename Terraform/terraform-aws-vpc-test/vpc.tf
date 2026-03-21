module "vpc"{
    source="git::https://github.com/saitehith28/Terraform-Modules.git//terraform-aws-vpc?ref=main"
    project=var.project
    environment=var.environment
    is_peering_required=true
}