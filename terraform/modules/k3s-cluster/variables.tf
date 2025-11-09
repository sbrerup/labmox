variable "init_node_ip" {
  type = string
}

variable "init_node_name" {
  type = string
}

variable "node_name" {
  type = string
}

variable "username" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "userpass" {
  type = string
}

variable "local_tf_storage" {
  type = string
}

variable "join_token" {
  type = string
}

variable "nodes" {
  type = map(object({
    vm_id  = number
    memory = number
    cpu    = number
    role   = string
    ipv4   = string
  }))
}
