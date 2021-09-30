variable "host" {
  description = "Ip address or dns record of the host trying to reach via ssh."
}

variable "port" {
  description = "Port of the target ssh daemon."
  default     = 22
}

variable "user" {
  description = "SSH user, which can be used for provisioning the host."
  default     = "root"
}
