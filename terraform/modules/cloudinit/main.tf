resource "proxmox_virtual_environment_file" "user_data" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/templates/user-data.yaml.tftpl", {
      hostname = var.hostname
      username = var.username
      ssh_key  = var.ssh_key
      userpass = var.userpass
    })

    file_name = "user-data-${var.hostname}.yaml"
  }
}

resource "proxmox_virtual_environment_file" "network_data" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  source_raw {
    data = templatefile("${path.module}/templates/networking.yaml.tftpl", {
      addresses = var.addresses
    })
    file_name = "network-data-${var.hostname}.yaml"
  }
}
