output "public_dns" {
  value = data.aws_instance.public-dns.public_dns
}

output "public_ip" {
  value = data.aws_instance.public-dns.public_ip
}