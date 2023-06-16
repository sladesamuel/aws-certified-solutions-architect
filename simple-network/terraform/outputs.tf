output "app_url" {
  description = "The URL of the the load balanced application"
  value       = aws_lb.app.dns_name
}
