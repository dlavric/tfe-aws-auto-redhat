resource "aws_instance" "instance" {
  ami                  = "ami-08d70e59c07c61a3a" # us-west-2
  instance_type        = "t2.medium"
  iam_instance_profile = aws_iam_instance_profile.daniela-profile.name

  credit_specification {
    cpu_credits = "unlimited"
  }

  key_name = var.key_pair

  root_block_device {
    volume_size = 40
  }

  user_data = templatefile("terraform_ent.yaml", {
    #consul_bootstrap_expect = var.consul_server_count,
    license = "license.rli"
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

resource "aws_iam_role" "daniela-role" {
  name = "daniela-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "daniela-profile" {
  name = "daniela-profile"
  role = aws_iam_role.daniela-role.name
}

resource "aws_iam_role_policy" "daniela-policy" {
  name = "daniela-policy"
  role = aws_iam_role.daniela-role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}



