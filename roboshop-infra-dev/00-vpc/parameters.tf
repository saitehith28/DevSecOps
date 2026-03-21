resource "aws_ssm_parameter" "vpc_id"{
    name="/${var.project}/${var.environemnt}/vpc_id"
    type="String"
    value=module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids"{
    name="/${var.project}/${var.environemnt}/public_subnet_ids"
    type="StringList"
    value=join(",",module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids"{
    name="/${var.project}/${var.environemnt}/private_subnet_ids"
    type="StringList"
    value=join(",",module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids"{
    name="/${var.project}/${var.environemnt}/database_subnet_ids"
    type="StringList"
    value=join(",",module.vpc.private_subnet_ids)
}