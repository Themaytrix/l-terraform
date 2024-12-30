



# setting up instance
# declare ami
# declare instance_type
# key_name - perm key downloaded - for ssh
# use security group as resource and vpc_security_groups_id as attribute

resource "aws_instance" "app_server" {
  ami                         = var.image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.achia2024.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  vpc_security_group_ids      = [var.vpc_security_group_ids[0]]
  user_data                   = file("newscaffold.sh")
  tags = {
    Name = "terraform-instance"
  }

  # # using provisioner to access user data for boostrap
  # provisioner "file" {
  #   # copy our executable to a remote location
  #   source = "webscaffold.sh"
  #   destination = "/tmp/webscaffold.sh"
  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     host = self.public_ip
  #     private_key = file("achia2024-key")
  #   }
  # }
  # # make our file executable
  # provisioner "remote-exec" {
  #   inline = [ 
  #     "chmod +x /tmp/webscaffold.sh",
  #     "sudo /tmp/webscaffold.sh"
  #   ]
  #   connection {
  #     type = "ssh"
  #     user = "ec2-user"
  #     host = self.public_ip
  #     private_key = file("achia2024-key")
  #   }
  # }

}

# ami-0ddc798b3f1a5117e

resource "aws_key_pair" "achia2024" {
  key_name   = "achia2024-key"
  public_key = file("achia2024-key.pub")
}
