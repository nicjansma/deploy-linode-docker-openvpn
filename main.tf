resource "linode_instance" "vpn" {
  label            = var.host_name
  type             = var.linode_type
  image            = var.linode_image
  region           = var.linode_region
  authorized_users = [var.authorized_user]
  root_pass        = var.root_password

  provisioner "file" {
    source      = "./files/"
    destination = "/tmp"

    connection {
      host        = self.ip_address
      user        = "root"
      private_key = file(var.ssh_key)
    }
  }

  provisioner "remote-exec" {
    scripts = ["./scripts/postinstall.sh"]

    connection {
      host        = self.ip_address
      user        = "root"
      private_key = file(var.ssh_key)
    }
  }
}

output "address" {
  value = linode_instance.vpn.ip_address
}

resource "aws_route53_record" "vpn" {
  zone_id = var.host_route_53_zone_id
  name    = var.host_name
  type    = "A"
  ttl     = "300"
  records = ["${linode_instance.vpn.ip_address}"]
}
