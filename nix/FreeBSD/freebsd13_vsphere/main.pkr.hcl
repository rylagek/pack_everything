packer {
    required_plugins {
        vsphere = {
            version = ">= 0.0.1"
            source = "github.com/hashicorp/vsphere"
        }
    }
}


source "vsphere-iso" "packer-freebsd13" {
  vm_name = var.template_name

  guest_os_type       = "freebsd64guest"
  convert_to_template = true

  create_snapshot = true

  firmware = "bios"

  iso_paths    = var.iso_paths
  #iso_url = "https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/13.0/FreeBSD-13.0-RELEASE-amd64-disc1.iso"
  #iso_checksum = "f78d4e5f53605592863852b39fa31a12f15893dc48cacecd875f2da72fa67ae5"

  boot_wait        = "5s"
  shutdown_command = "echo ${var.ssh_password} | sudo -S shutdown -p now"
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_port         = 22
  ssh_timeout      = "40m"
  ssh_handshake_attempts = "100000"
  remove_cdrom = true
  tools_upgrade_policy = true

  boot_command = [
         "<wait><wait><wait><wait>",             # wait for menu-screen
         "<enter><wait>",                        # select default multi-user
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       # wait for install menu-screen
         "<wait><wait><wait><wait><wait>",       #
         "<enter><wait>",                        # install
         "<enter><wait>",                        # continue with default keymap
         "freebsd13<wait><enter><wait>",         # set hostname
         "<enter><wait>",                        # choose optional system components to install
         "<enter><wait>",                        # Choose how to partition disk (choose default auto zfs)
         "<enter><wait>",                        # proceed with zfs configuration, default
         "<enter><wait><wait>",                  # default stripe - no redundancy
         " <wait><enter><wait>",                       # zfs configuration, choose vmware virtual disk
         "<tab><enter><wait>",                   # confirm zfs configuration, overwrite disk
         "<wait><wait><wait><wait><wait>",       # wait until installation on drive is complete
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "${var.ssh_password}<wait><enter>",     # new password for local root
         "<wait>",                               #
         "${var.ssh_password}<wait><enter>",     # confirm new password for local root
         "<wait>",                               #
         "<enter><wait><wait><wait>",            # select nic to configure (default)
         "<enter><wait><wait><wait>",            # configure ipv4 (default)
         "<enter><wait><wait><wait>",            # configure DHCP (default)
         "<wait><wait><wait><wait><wait>",       #
         "<enter><wait><wait><wait>",            # configure ipv6 (default)
         "<enter><wait><wait><wait>",            # configure SLAAC (default)
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<tab><wait><enter><wait>",             # confirm network configurations
         "0 <wait><enter><wait>",                # choose UTC (0) for time
         "<enter><wait><wait><wait>",            # confirm UTC looks reasonable
         "<enter><wait><wait><wait>",            # skip date
         "<enter><wait><wait><wait>",            # skip time
         "6 <wait><enter><wait>",                # system security hardening, choose to clear_tmp
         "<enter><wait>",                        # create new user
         "packer<wait><enter>",                  # username
         "packer<wait><enter>",                  # full name
         "<enter><wait>",                        # uid
         "<enter><wait>",                        # login group
         "wheel<wait><enter>",                   # other group
         "<enter><wait>",                        # login class default
         "<enter><wait>",                        # default sh
         "<enter><wait>",                        # default home dir
         "<enter><wait>",                        # default home dir permissions
         "<enter><wait>",                        # use password-based auth default [yes]
         "<enter><wait>",                        # empty password default no
         "<enter><wait>",                        # random password default no
         "${var.ssh_password}<wait><enter>",    # password
         "${var.ssh_password}<wait><enter>",    # confirm password
         "<enter><wait>",                        # default do not lock account
         "yes<wait><enter>",                     # ok with user configs
         "no<wait><enter>",                      # add another user
         "<enter><wait>",                        # apply configs and exit installer
         "<enter><wait>",                        # do not open a shell for manual modifications right now
         "<enter><wait>",                        # reboot
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       # Wait for reboot
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "root<wait><enter>",                    # login as root
         "${var.ssh_password}<wait><enter>",    #
         "<wait><wait>",                         #
         "pkg update<enter><wait>",              # update package manager
         "y<enter>",                             # confirm with yes
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "pkg install sudo open-vm-tools<wait><enter>", # install open-vm-tools
         "y<enter>",                             # confirm with yes
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       # waiting on pkg to install tools
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "<wait><wait><wait><wait><wait>",       #
         "visudo<enter><wait>",                  # edit sudoers file
         "/root ALL=(ALL:ALL) ALL<enter>",       # go to line that has root ALL=(ALL:ALL) ALL
         "o",                                    # insert mode under
         "packer ALL=(ALL:ALL) ALL",             # let packer run sudo commands
         "<esc>:wq<enter>",                      #
         "<wait><wait><wait><wait><wait>",       #
         "init 6<wait><enter>",                  # restart system for open-vm-tools to take effect
      ]

  CPUs = var.num_cpus
  RAM  = var.ram

  disk_controller_type = ["lsilogic-sas"]
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = true
  }

  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }


  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  datacenter          = var.vcenter_datacenter
  host                = var.vcenter_host
  datastore           = var.vcenter_datastore
  notes               = "Root: <paul-password>"

  insecure_connection = true
}


build {
  sources = ["source.vsphere-iso.packer-freebsd13"]
}

