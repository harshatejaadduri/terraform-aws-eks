resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  iam_instance_profile = "TerrafromEc2Access"
  
  root_block_device{
    volume_size = 50
    volume_type = "gp3"
  }
  
  user_data = file("install.sh")

  tags = merge( local.common_tags, {
    Name = "${var.project}-${var.environment}-bastion"
  }
  )
}

