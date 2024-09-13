output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.db.address
  sensitive   = true
}
output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db.port
  sensitive   = true
}
output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.db.username
  sensitive   = true
}
output "endpoints" {
  value = <<EOF
AWS RDS Endpoint:  ${aws_db_instance.db.endpoint}
For example:
    mysql -h ${aws_db_instance.db.id} -P ${aws_db_instance.db.port} -u ${aws_db_instance.db.username} -p
Jump Server IP (public):  ${aws_instance.jump.public_ip}
Jump Server IP (private): ${aws_instance.jump.private_ip}
For example:
   ssh -i ${aws_key_pair.main.key_name}.pem ubuntu@${aws_instance.jump.public_ip}
APP Client IP (private): ${aws_instance.application.private_ip}
For example:
   ssh -i ${aws_key_pair.main.key_name}.pem ubuntu@${aws_instance.application.private_ip}
EOF
}

# output "private_key" {
#   value = tls_private_key.main.private_key_pem
# }

output "private_key" {
  value = nonsensitive(tls_private_key.main.private_key_pem)
}