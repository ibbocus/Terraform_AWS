output "bastion_ip" {
  description = "The ID of the Bastion"
  value       = "${aws_instance.Bastion_instance.public_ip}"
}

output "app_ip" {
  description = "The ID of the APP"
  value       = "${aws_instance.App_instance.public_ip}"
}

output "db_ip" {
  description = "The ID of the DB"
  value       = "${aws_instance.DB_instance.public_ip}"
}

