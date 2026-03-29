module "component" {
    for_each = var.components
    source = "git::https://github.com/saitehith28/Terraform-Modules.git//terraform-roboshop-components?ref=main"
    component = each.key
    rule_priority = each.value.rule_priority
}