resource "aws_ssm_parameter" "k8-vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"   /* name should start with / */
  type  = "String"
  value = module.k8-vpc.vpc_id
}

 resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public_subnet_ids"   
  type  = "StringList"
  value =  join(",", module.k8-vpc.public_subnet_ids)
    }

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"   
  type  = "StringList"
  value =  join(",", module.k8-vpc.private_subnet_ids)
    }


resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"   
  type  = "StringList"
  value =  join(",", module.k8-vpc.database_subnet_ids)
    }