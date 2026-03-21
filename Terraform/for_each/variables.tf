# Map
# variable "instances" {
#     type = map
#     default = {
#         mongodb = "t3.micro"
#         mysql = "t3.small"
#         user = "t3.micro"
#         shipping = "t3.small"
#     }
# }
# This should be converted into set
variable "instances" {
    type = list
    default = ["mongodb", "redis","frontend"]
}
variable "zone_id" {
    default = "Z07424761Y3CDV3OLV2IR"
}

variable "domain_name" {
    default = "tehith.online"
}