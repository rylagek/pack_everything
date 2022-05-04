# vSphere vCenter Builder Source
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

source "virtualbox-iso" "vbox" {
  boot_command            = ["<esc><wait>", "install <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=kali ", "domain='' ", "<enter>"]
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "Debian_64"
  http_directory          = "http"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password            = "vagrant"
  ssh_timeout             = "60m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--clipboard-mode", "bidirectional"], ["modifyvm", "{{ .Name }}", "--draganddrop", "bidirectional"]]
  virtualbox_version_file = ""
}

source "vmware-iso" "vmware" {
  boot_command         = ["<esc><wait>", "install <wait>", "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ", "locale=en_US ", "keymap=us ", "hostname=kali ", "domain='' ", "<enter>"]
  cpus                 = "2"
  guest_os_type        = "debian10-64"
  http_directory       = "http"
  iso_checksum         = "sha256:${var.iso_checksum}"
  iso_url              = "${var.iso_url}"
  memory               = "2048"
  network              = "nat"
  network_adapter_type = "vmxnet3"
  shutdown_command     = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password         = "vagrant"
  ssh_timeout          = "60m"
  ssh_username         = "vagrant"
  vmx_data_post = {
    "ide0:0.clientDevice"   = "TRUE"
    "ide0:0.deviceType"     = "cdrom-raw"
    "ide0:0.fileName"       = "emptyBackingString"
    "ide0:0.present"        = "FALSE"
    "ide0:0.startConnected" = "FALSE"
  }
}