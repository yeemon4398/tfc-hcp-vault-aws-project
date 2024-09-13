##### JUMP Server  #####
resource "aws_instance" "jump" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.main.key_name
  subnet_id = data.aws_subnets.public_subnet_ids.ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.security_group_public_ssh.id]

  tags = {
    Name = "ec2-public-instance"
  }
  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}

resource "aws_security_group" "security_group_public_ssh" {
  name   = var.public_ssh_security_group_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.public_ssh_security_group_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "public" {
  security_group_id = aws_security_group.security_group_public_ssh.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

##### Application Server  #####
resource "aws_instance" "application" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.main.key_name
  subnet_id = data.aws_subnets.private_subnet_ids.ids[0]
  vpc_security_group_ids = [aws_security_group.security_group_private_ssh.id]

  tags = {
    Name = "ec2-private-instance"
  }
  lifecycle {
    ignore_changes = [
      ami,
      tags,
    ]
  }
}

resource "aws_security_group" "security_group_private_ssh" {
  name   = var.private_ssh_security_group_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.private_ssh_security_group_name
  }
}
resource "aws_vpc_security_group_ingress_rule" "private" {
  for_each = data.aws_subnet.public_subnet
  security_group_id = aws_security_group.security_group_private_ssh.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

##### Create RDS #####
resource "aws_db_instance" "db" {
  engine = "mysql"
  engine_version = "8.0.35"
  identifier = "mysql01"
  username = "admin"
  password = var.password
  instance_class = "db.t3.micro"
  allocated_storage = "20"
  max_allocated_storage = "50"
  db_subnet_group_name = var.db_subnet
  vpc_security_group_ids = [aws_security_group.security_group_db.id]
  db_name = "prj_db"
  #add
  skip_final_snapshot    = true
}

resource "aws_security_group" "security_group_db" {
  name   = var.db_security_group_name
  vpc_id = var.vpc_id
  tags = {
    Name = var.db_security_group_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  for_each = data.aws_subnet.private_subnet
  security_group_id = aws_security_group.security_group_db.id
  cidr_ipv4   = each.value.cidr_block
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

resource "aws_vpc_security_group_ingress_rule" "vault" {
  security_group_id = aws_security_group.security_group_db.id
  cidr_ipv4   = var.vault_cidr_block
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}