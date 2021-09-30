resource "null_resource" "host" {
  connection {
    agent = true
    host  = var.host
    port  = var.port
    user  = var.user
    type  = "ssh"
  }

  provisioner "remote-exec" {
    inline = [
      "hostnamectl"
    ]
  }
}
