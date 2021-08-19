resource "aws_instance" "name" {
  ami                         = "ami-0c2b8ca1dad447f8a"
  instance_type               = "t2.micro"
  key_name                    = "terraform-key"
  vpc_security_group_ids      = ["${aws_security_group.ssh-allowed.id}"]
  subnet_id                   = "${aws_subnet.public-1.id}"
  associate_public_ip_address = "true"

  root_block_device {
    volume_size           = "10"
    volume_type           = "standard"
    delete_on_termination = "true"
  }

  tags = {
    Name = "name_server"
  }
}