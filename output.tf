output "url" {
  value = var.hostname == null ? null : "https://${var.hostname}"
}