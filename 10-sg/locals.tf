locals {
  
vpc_id = data.aws_ssm_parameter.k8-vpc_id.value

}