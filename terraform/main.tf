provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.token
  insecure  = true

  ssh {
    agent    = true
    username = "root"

    node {
      name    = "labmox"
      address = "10.0.0.2"
      port    = 22
    }
  }
}

module "k3s_cluster" {
  source           = "./modules/k3s-cluster"
  init_node_ip     = var.init_node_ip
  init_node_name   = var.init_node_name
  join_token       = var.join_token
  local_tf_storage = var.local_tf_storage
  node_name        = var.node_name
  ssh_key          = var.ssh_key
  username         = var.username
  userpass         = var.temp_userpass
  nodes            = var.nodes
}
