variable "iso_checksum" {
  type    = string
  default = "b584020dcce3a2281876be24b0c48a5d6641b787967ccd269028ff72e4a96065"
}

variable "iso_url" {
  type    = string
  default = "https://download.freenas.org/12.0/STABLE/U7/x64/TrueNAS-12.0-U7.iso?__hstc=123088916.c2f77ebf39729f61b2001e414a86dbcf.1642087483193.1642087483193.1642087483193.1&__hssc=123088916.6.1642087483194&__hsfp=595568833"
}

source "virtualbox-iso" "vbox" {
  boot_command = [
    "<enter><wait10>",
    "1<enter><wait5>",
    "y<wait5>",
    "<spacebar><enter><wait5>",
    "<enter><wait5>",
    "truenas<tab>truenas<tab><enter><wait5>",
    "<enter>",
    "<wait5m>",
    "<enter><wait5>",
    "3<enter>",
    "<wait5m>",
    "9<enter><wait5>",
    "curl -X PUT -u root:truenas http://localhost/api/v2.0/ssh -H  'accept: */*' -H  'Content-Type: application/json' -d \"{\\\"tcpport\\\":22,\\\"rootlogin\\\":true,\\\"passwordauth\\\":true}\"",
    "<enter><wait10>",
    "curl -X POST -u root:truenas 'http://localhost/api/v2.0/service/start' -H  'accept: */*' -H  'Content-Type: application/json' -d \"{\\\"service\\\":\\\"ssh\\\",\\\"service-control\\\":{\\\"ha_propagate\\\":true}}\"",
    "<enter><wait10>"
  ]
  boot_wait               = "5s"
  cpus                    = "2"
  guest_additions_mode    = "disable"
  guest_os_type           = "FreeBSD_64"
  iso_checksum            = "sha256:${var.iso_checksum}"
  iso_url                 = "${var.iso_url}"
  memory                  = "2048"
  shutdown_command        = "shutdown -p now"
  ssh_password            = "truenas"
  ssh_timeout             = "5m" # boot commands start ssh, so this should be instantaneous. fail fast if something is wrong.
  ssh_username            = "root"
  virtualbox_version_file = ""
  vm_name                 = "packer-truenas-12U7-amd64"
}


build {
  sources = ["source.virtualbox-iso.vbox"]
}
