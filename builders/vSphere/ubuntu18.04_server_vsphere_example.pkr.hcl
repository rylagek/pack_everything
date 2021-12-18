
source "vsphere-iso" "vsphere" {
  CPUs                  = 2
  RAM                   = 2048
  RAM_reserve_all       = true
  boot_command          = ["<enter><wait><f6><wait><esc><wait>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>", "<bs><bs><bs>", "/install/vmlinuz", " initrd=/install/initrd.gz", " priority=critical", " locale=en_US", " file=/media/preseed_server.cfg", "<enter>"]
  boot_order            = "disk,cdrom"
  cluster               = "${var.cluster}"
  convert_to_template   = "true"
  datastore             = "${var.datastore}"
  disk_controller_type  = "pvscsi"
  disk_size             = 10737
  disk_thin_provisioned = true
  floppy_files          = ["./http/preseed_server.cfg"]
  folder                = "${var.folder}"
  guest_os_type         = "ubuntu64Guest"
  host                  = "${var.host}"
  insecure_connection   = "true"
  iso_checksum          = "a2cb36dc010d98ad9253ea5ad5a07fd6b409e3412c48f1860536970b073c98f5"
  iso_checksum_type     = "sha256"
  iso_urls              = "http://cdimage.ubuntu.com/releases/18.04/release/ubuntu-18.04.2-server-amd64.iso"
  network               = "${var.network}"
  network_card          = "vmxnet3"
  password              = "${var.password}"
  resource_pool         = "${var.resource_pool}"
  ssh_password          = "${var.ssh_password}"
  ssh_username          = "${var.ssh_username}"
  username              = "${var.username}"
  vcenter_server        = "${var.vcenter_server}"
  vm_name               = "ubuntu18_server_no_rdp"
}

build {
  sources = ["source.vsphere-iso.vsphere"]

  provisioner "shell" {
    inline = ["echo 'template build - starting configuration by deploying base packages/applications'"]
  }

  provisioner "shell" {
    execute_command   = "echo '${var.password}' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    expect_disconnect = true
    pause_before      = "10s"
    scripts           = ["scripts/packer_install_base_packages.sh", "scripts/packer_image_cleanup.sh"]
  }

  provisioner "shell" {
    inline = ["echo 'template build - start configuring ssh access'"]
  }

  provisioner "shell" {
    inline = ["mkdir -p ${var.image_home_dir}${var.ssh_username}/.ssh"]
  }

  provisioner "file" {
    destination = "${var.image_home_dir}${var.ssh_username}/.ssh/authorized_keys"
    source      = "${var.ssh_key_src_pub}"
  }

  provisioner "shell" {
    inline = ["sudo chown -R ${var.ssh_username}:${var.ssh_username} ${var.image_home_dir}${var.ssh_username}", "sudo chmod go-w ${var.image_home_dir}${var.ssh_username}/", "sudo chmod 700 ${var.image_home_dir}${var.ssh_username}/.ssh", "sudo chmod 600 ${var.image_home_dir}${var.ssh_username}/.ssh/authorized_keys"]
  }

  provisioner "shell" {
    inline = ["echo 'template build - test the image'"]
  }

  provisioner "inspec" {
    profile = "test/ImageBuild"
  }

  provisioner "shell" {
    inline = ["echo 'template build - disable ssh password access'"]
  }

  provisioner "shell" {
    inline = ["sudo su root -c \"sed '/ChallengeResponseAuthentication/d' -i /etc/ssh/sshd_config | sudo bash\"", "sudo su root -c \"sed '/PasswordAuthentication/d' -i /etc/ssh/sshd_config | sudo bash\"", "sudo su root -c \"sed '/UsePAM/d' -i /etc/ssh/sshd_config | sudo bash\"", "sudo su root -c \"echo  >> /etc/ssh/sshd_config | sudo bash\"", "sudo su root -c \"echo 'ChallengeResponseAuthentication no' >> /etc/ssh/sshd_config | sudo bash\"", "sudo su root -c \"echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config | sudo bash\""]
  }

  provisioner "shell" {
    inline = ["echo 'template build - complete'"]
  }

}