resource "null_resource" "host" {
  connection {
    agent = true
    host  = var.host_ip
    port  = var.host_port
    user  = var.ssh_user
    type  = "ssh"
  }

  provisioner "remote-exec" {
    inline = [
      "hostnamectl"
    ]
  }
}
