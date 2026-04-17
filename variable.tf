variable "instances" {
  description = "Number of EC2 instances to create"
  type        = list(string)
  default     = ["web-server-1", "web-server-2", "web-server-3", "web-server-4"]
}