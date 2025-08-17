data "aws_ssm_parameter" "k8-vpc_id" {
  name = "/${var.project}/${var.environment}/vpc_id"
}