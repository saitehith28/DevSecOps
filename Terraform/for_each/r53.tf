resource "aws_route53_record" "www" {
  for_each=aws_instance.example
  zone_id = var.zone_id
  # interpolation
  name    = "${each.key}.${var.domain_name}" # mongodb.daws88s.online
  type    = "A"
  ttl     = 1
  records = [each.value.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "public" {
  zone_id = var.zone_id
  # interpolation
  name    = "roboshop.${var.domain_name}" # mongodb.daws88s.online
  type    = "A"
  ttl     = 1
  records = [lookup(aws_instance.example,"frontend").public_ip]
  allow_overwrite = true
}