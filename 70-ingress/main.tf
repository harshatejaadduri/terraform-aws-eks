module "ingress_alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = false
  name    = "${var.project}-${var.environment}-ingress-alb"
  vpc_id  = local.vpc_id
  subnets = local.public_subnet_ids
  enable_deletion_protection = false
  create_security_group = false #as we are creating as our own sg for alb
  security_groups = [local.ingress_alb_sg_id]

  tags = merge( local.common_tags, {
    Name = "${var.project}-${var.environment}-ingress-alb"
  }
  )
}

resource "aws_lb_listener" "ingress_alb" {
  load_balancer_arn = module.ingress_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = local.acm_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I'm From ingress ALB<h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "ingress_alb" {
  zone_id = var.zone_id
  name    = "${var.environment}.${var.domain_name}"
  type    = "A"

  alias { 
    name                   = module.ingress_alb.dns_name #alb zone name
    zone_id                = module.ingress_alb.zone_id  #alb zone id 
    evaluate_target_health = true
  }
}
