# pack_everything
Generic [Packer](https://www.packer.io/docs) Templates with [chained builders](https://medium.com/swlh/chaining-machine-image-builds-with-packer-b6fd99e35049) for [Vagrant](https://www.packer.io/docs/builders/vagrant), [VirtualBox](https://www.packer.io/docs/builders/virtualbox/iso), [VMWare](https://www.packer.io/docs/builders/vmware/iso), and [vSphere](https://www.packer.io/docs/builders/vsphere/vsphere-iso)

## OS List
**\*Nix in Order of Priority**

| 1) Ubuntu 20.04 Desktop | 13) Raspberry Pi OS |
|:-|:-|
| 2) Ubuntu 20.04 Server | 14) TAILS |
| 3) Rocky Linux | 15) Ubuntu 16.04 Desktop |
| 4) Kali Linux | 16) Ubuntu 16.04 Server |
| 5) TrueNAS | 17) REMNUX |
| 6) Security Onion | 18) Qubes OS |
| 7) SIFT | 19) OpenBSD |
| 8) pfSense Router | 20) Parrot |
| 9) Arch | 21) PureOS |
| 10) FreeBSD | 22) Gentoo |
| 11) busybox | 23) Pentoo |
| 12) Oracle Solaris | 24) Debian 11 |

**Windows in Order of Priority**
| 1) Windows 10 | 4) Windows 7 |
|:-|:-|
| 2) Windows Server 2k19 | 5) Windows XP |
| 3) Windows Vista | 6) Windows Server 2k12 |

## File Structure
#### `builders` holds example source and builder `pkr.hcl` blocks for each build type

#### `nix` and `windows` each hold the packer files required for successful builds
```
├───builders
│   ├───vagrant
│   ├───vbox
│   ├───vmWare
│   └───vSphere
├───nix
│   ├───Arch
│   ├───busybox
│   ├───Debian 11
│   ├───FreeBSD
│   ├───Gentoo
│   ├───Kali Linux
│   ├───OpenBSD
│   ├───Oracle Solaris
│   ├───Parrot
│   ├───Pentoo
│   ├───pfSense Router
│   ├───PureOS
│   ├───Qubes OS
│   ├───Raspberry Pi OS
│   ├───REMNUX
│   ├───Rocky Linux
│   ├───Security Onion
│   ├───SIFT
│   ├───TAILS
│   ├───TrueNAS
│   ├───Ubuntu 16.04 Desktop
│   ├───Ubuntu 16.04 Server
│   ├───Ubuntu 20.04 Desktop
│   └───Ubuntu 20.04 Server
└───windows
    ├───Windows 10
    ├───Windows 7
    ├───Windows Server 2k12
    ├───Windows Server 2k19
    ├───Windows Vista
    └───Windows XP
```

## Helpful VMware Documentation:
[GuestOsDescriptor](https://developer.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html)
[VMware-Tools](https://docs.vmware.com/en/VMware-Tools/11.3.0/com.vmware.vsphere.vmwaretools.doc/GUID-C48E1F14-240D-4DD1-8D4C-25B6EBE4BB0F.html)

## Notes
How to run: Navigate to proper directory that contains file "packer"
run the command: `packer build packer` and it should build the vm in that folder assumning there are `.pkr.hcl` files in the directory

## Questions:
1. How to run `.pkr.hcl` on Windows and Linux?
  Packer commands are the same across operating systems - running `packer` without additional arguments will list all possible commands
