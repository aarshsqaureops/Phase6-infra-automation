module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["1", "2", "3"])

  name = "mongo-aarsh-${each.key}"

  ami                    = "ami-0530ca8899fac469f"
  instance_type          = "t3a.small"
  key_name               = "aarsh"
  monitoring             = true
  vpc_security_group_ids = [resource.aws_security_group.mongo-sg-aarsh.id]
  subnet_id              = module.vpc.private_subnets[0]

  user_data = file("shell.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

#Mongo EC2 Security group
resource "aws_security_group" "mongo-sg-aarsh" {
  name        = "mongo-sg-aarsh"
  description = "MongoDB inbound"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "mongo-sg-aarsh"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "mongo-sg-aarsh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mongo-sg-aarsh"
  }
}