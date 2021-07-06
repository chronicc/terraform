variable "host_ip" {
  description = "IP address of the host trying to reach via ssh."
}

variable "host_port" {
  description = "Port of the host trying to reach via ssh."
  default     = 22
}

variable "ssh_user" {
  description = "SSH user, which can be used for provisioning the host."
}
