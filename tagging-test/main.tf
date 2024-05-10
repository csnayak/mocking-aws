locals {
  config = yamldecode(file("${path.module}/tags.yaml"))
}

resource "aws_instance" "example" {
  for_each = local.config.instance_tags

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags          = each.value
}


