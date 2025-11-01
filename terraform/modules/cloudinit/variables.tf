variable "hostname" {
  description = "The hostname to set in the cloud-init config and to use in the filename."
  type        = string
}

variable "username" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "userpass" {
  type = string
}

variable "node_name" {
  description = "The Proxmox node where the snippet will be uploaded."
  type        = string
}

variable "datastore_id" {
  description = "The datastore to upload the snippet to."
  type        = string
  default     = "local"
}

variable "addresses" {
  type        = list(string)
  description = "Ip addresses for the VM."
}

variable "server_node_ip" {
  type = string
}

variable "join_token" {
  type = string
}

variable "role" {
  type = string
}

variable "cluster_init" {
  type    = bool
  default = false
}
