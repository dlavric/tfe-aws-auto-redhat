resource "aws_instance" "instance" {
  ami           = "ami-08d70e59c07c61a3a" # us-west-2
  instance_type = "t2.medium"

  credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = var.key_pair

  root_block_device {
    volume_size = 40
  }

  user_data = templatefile("terraform_ent.yaml", {
    #consul_bootstrap_expect = var.consul_server_count,
    #public_ip = aws_instance.public-dns.public_ip
  })

  # user_data = templatefile("cloudinit_tfe_server.yaml", {
  #     mykey = var.mykey
  #   })

  tags = {
    Name = var.instance_name
  }
}


data "aws_route53_zone" "zone" {
  name = "bg.hashicorp-success.com"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "daniela.${data.aws_route53_zone.zone.name}"
  type    = "A"
  ttl     = "300"
  records = [data.aws_instance.public-dns.public_ip]
}


data "aws_instance" "public-dns" {
  instance_id = aws_instance.instance.id
  depends_on  = [aws_instance.instance]

  filter {
    name   = "tag:Name"
    values = ["ServerForTFE"]
  }
}



