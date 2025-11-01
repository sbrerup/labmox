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

module "k3s_server_01_cloudinit" {
  source       = "./modules/cloudinit"
  hostname     = "k3s-server-01"
  addresses    = ["10.0.0.10"]
  node_name    = var.node_name
  username     = "sbrerup"
  userpass     = var.userpass
  ssh_key      = var.ssh_key
  datastore_id = var.local_tf_storage
}

# resource "proxmox_virtual_environment_vm" "k3s_server_01" {
#   vm_id     = 100
#   node_name = var.node_name
#   name      = "k3s-server-01"
#   started   = true

#   clone {
#     full  = true
#     vm_id = 8000
#   }

#   disk {
#     datastore_id = "local-zfs"
#     interface    = "scsi0"
#     size         = 20
#   }


#   initialization {
#     datastore_id         = "local-zfs"
#     user_data_file_id    = module.k3s_server_01_cloudinit.user_data_file_id
#     network_data_file_id = module.k3s_server_01_cloudinit.network_data_file_id
#   }
# }
