locals {
    common_tags = {
        Project = var.project_name
        Environment = var.env
        Terraform = "true"
    }
    ec2_final_tags = merge(
        local.common_tags
    )
}