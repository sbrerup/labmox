module "k3s_init_node_cloudinit" {
  source         = "../cloudinit"
  hostname       = var.init_node_name
  addresses      = ["${var.init_node_ip}/24"]
  node_name      = var.node_name
  username       = var.username
  userpass       = var.userpass
  ssh_key        = var.ssh_key
  datastore_id   = var.local_tf_storage
  role           = "server"
  join_token     = var.join_token
  server_node_ip = var.init_node_ip
  cluster_init   = true
}

resource "proxmox_virtual_environment_vm" "k3s_init_node" {
  depends_on = [module.k3s_init_node_cloudinit]
  vm_id      = 1000
  node_name  = var.node_name
  name       = var.init_node_name
  started    = true

  clone {
    full  = true
    vm_id = 8000
  }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    size         = 20
  }

  memory {
    dedicated = 4096
  }

  cpu {
    cores = 2
    type  = "host"
  }

  initialization {
    datastore_id         = "local-zfs"
    user_data_file_id    = module.k3s_init_node_cloudinit.user_data_file_id
    network_data_file_id = module.k3s_init_node_cloudinit.network_data_file_id
  }
}


module "k3s_cloud_init_configs" {
  depends_on     = [proxmox_virtual_environment_vm.k3s_init_node]
  for_each       = var.nodes
  source         = "../cloudinit"
  hostname       = each.key
  addresses      = ["${each.value.ipv4}/24"]
  node_name      = var.node_name
  username       = var.username
  userpass       = var.userpass
  ssh_key        = var.ssh_key
  datastore_id   = var.local_tf_storage
  role           = each.value.role
  join_token     = var.join_token
  server_node_ip = var.init_node_ip
}

resource "proxmox_virtual_environment_vm" "k3s_nodes" {
  depends_on = [module.k3s_cloud_init_configs]
  for_each   = var.nodes
  vm_id      = each.value.vm_id
  node_name  = var.node_name
  name       = each.key
  started    = true

  clone {
    full  = true
    vm_id = 8000
  }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    size         = 50
  }

  dynamic "disk" {
    for_each = each.value.role == "agent" ? [1] : []

    content {
      datastore_id = "local-zfs"
      interface    = "scsi1"
      size         = 512
      iothread     = true
      discard      = "on"
    }
  }

  memory {
    dedicated = each.value.memory
  }

  cpu {
    cores = each.value.cpu
    type  = "host"
  }

  initialization {
    datastore_id         = "local-zfs"
    user_data_file_id    = module.k3s_cloud_init_configs[each.key].user_data_file_id
    network_data_file_id = module.k3s_cloud_init_configs[each.key].network_data_file_id
  }
}
