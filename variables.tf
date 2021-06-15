##
# Required
##

variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "hostname" {
  type = string
}
variable "loadbalancer_rule_arn" {
  type = string
}
variable "task_port" {
  type = number
}
variable "tags" {
  type = map(any)
}

##
# Optionals
##

variable "container_secrets" {
  type    = any
  default = []
}
variable "container_environment" {
  type    = any
  default = []
}
variable "task_cpu" {
  type    = number
  default = 1024
}
variable "task_memory" {
  type    = number
  default = 2048
}
variable "autoscaling_min_capacity" {
  type    = number
  default = 1
}
variable "autoscaling_max_capacity" {
  type    = number
  default = 10
}
variable "autoscalling_tracking_cpu_at" {
  type    = number
  default = 80
}
variable "autoscalling_tracking_memory_at" {
  type    = number
  default = 80
}
variable "cloudwatch_logs_retention" {
  type    = number
  default = 7
}
variable "healthcheck_protocol" {
  type    = string
  default = "HTTP"
}
variable "healthcheck_path" {
  type    = string
  default = "/"
}
variable "healthcheck_interval" {
  type    = number
  default = 30
}
variable "healthcheck_timeout" {
  type    = number
  default = 20
}
variable "healthcheck_success_codes" {
  type    = string
  default = "200"
}
variable "healthcheck_healthy_threshold" {
  type    = number
  default = 2
}
variable "healthcheck_unhealthy_threshold" {
  type    = number
  default = 5
}
