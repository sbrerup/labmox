locals {
  common_template_vars = {
    hostname     = var.hostname
    username     = var.username
    ssh_keys     = var.ssh_keys
    userpass     = var.userpass
    join_token   = var.join_token
    cluster_init = var.cluster_init
  }

  agent_template_vars = {
    server_node_ip = var.server_node_ip
  }

  template_config = var.role == "agent" ? {
    file_path = "${path.module}/templates/agent-user-data.yaml.tftpl"
    vars      = merge(local.common_template_vars, local.agent_template_vars)
    } : {
    file_path = "${path.module}/templates/server-user-data.yaml.tftpl"
    vars      = local.common_template_vars
  }
}

resource "proxmox_virtual_environment_file" "user_data" {
  content_type = "snippets"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  source_raw {
    data      = templatefile(local.template_config.file_path, local.template_config.vars)
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
