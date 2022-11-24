output "public_dns" {
  value = data.aws_instance.public-dns.public_dns
}

output "public_ip" {
  value = data.aws_instance.public-dns.public_ip
}

output "user_template" {
  value = templatefile("terraform_ent.yaml", {
    license = "license.rli"
  })
}
