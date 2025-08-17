locals {
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    ingress_alb_sg_id = data.aws_ssm_parameter.ingress_alb_sg_id.value
    public_subnet_ids = split("," , data.aws_ssm_parameter.public_subnet_ids.value)
    acm_arn = data.aws_ssm_parameter.acm_arn.value
    common_tags = {
    Project = var.project
    Environment = var.environment
    Terraform = "true"
  } 
   }