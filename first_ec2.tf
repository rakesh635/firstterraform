provider "aws" {
	region = "us-east-1"
}

resource "aws_instance" "tf_ec2_1" {
	ami = "ami-053b0d53c279acc90"
	instance_type = "t2.micro"
	key_name = "rakeshkeypair"
	vpc_security_group_ids = [aws_security_group.tf_allow_ssh.id]
	subnet_id = "subnet-0a00e3f8144655d78"
	associate_public_ip_address = "true"
	ebs_block_device {
		device_name = "/dev/sda1"
		volume_size = 30
		delete_on_termination = "true"
		encrypted = "true"
	}
	tags = {
		name = "tf_ec2_1"
		createdby = "terraform"
	}
}

resource "aws_security_group" "tf_allow_ssh" {
	name        = "allow_ssh"
	description = "Allow SSH inbound traffic from my working machine"
	vpc_id      = "vpc-05be22f7ef63afaa7"

	ingress {
		description = "SSH from my Machine"
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["136.226.243.5/32"]
	}

	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		name = "allow_ssh"
		createdby = "terraform"
	}
}
