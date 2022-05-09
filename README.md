# pack_everything
Generic [Packer](https://www.packer.io/docs) Templates with [chained builders](https://medium.com/swlh/chaining-machine-image-builds-with-packer-b6fd99e35049) for [Proxmox](https://www.packer.io/plugins/builders/proxmox/iso), [Vagrant](https://www.packer.io/docs/builders/vagrant), [VirtualBox](https://www.packer.io/docs/builders/virtualbox/iso), [VMWare](https://www.packer.io/docs/builders/vmware/iso), and [vSphere](https://www.packer.io/docs/builders/vsphere/vsphere-iso)

## OS List
**\*Nix in Order of Priority**

| 1) Ubuntu 20.04 Desktop | 14) TAILS |
|:-|:-|
| 2) Ubuntu 20.04 Server | 15a) Ubuntu 16.04 Server |
| 3) Rocky Linux | 15b) Ubuntu 16.04 Desktop |
| 4) Kali Linux | 16) Project 9 |
| 5) TrueNAS | 17) REMNUX |
| 6) Security Onion | 18) Qubes OS |
| 7) SIFT | 19) OpenBSD |
| 8) pfSense Router | 20) Parrot |
| 9) Arch | 21) PureOS |
| 10) FreeBSD | 22) Gentoo |
| 11) busybox | 23) Pentoo |
| 12) Oracle Solaris | 24) Debian 11 |
| 13) Raspberry Pi OS | 25) Slackware |

**Windows in Order of Priority**
| 1) Windows 10 | 5) Windows 7 |
|:-|:-|
| 2) Windows Server 2k19 | 6) Windows XP |
| 3) Windows Server 2k16 | 7) Windows Server 2k12 |
| 4) Windows Vista ||

## File Structure
#### `builders` holds example source and builder `pkr.hcl` blocks for each build type

#### `nix` and `windows` each hold the packer files required for successful builds
- please contribute in these folders, not in `builders`
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

## Getting started
1) Clone this repo: `git clone https://github.com/rylagek/pack_everything`
2) [Install](https://www.packer.io/docs/install) `packer` 
3) Navigate to your desired OS and virtualization environment directory that contains file "packer" (ex `~/nix/Arch/Proxmox` or `~/Windows/10/VirtualBox/`)
4) Run the command: `packer build packer` and it should build the vm with your selected provider assumming there are `.pkr.hcl` files in the directory and the provider is configured

## FAQ:
1. How to run `.pkr.hcl` on Windows and Linux?
  Packer commands are the same across operating systems - running `packer` without additional arguments will list all possible commands
3. How to see the development status for virtualization environments or operating systems?
  Check out the build notes and checklists in our [Wiki](https://github.com/rylagek/pack_everything/wiki)
5. How to request an operating system to be added to the build list?
  [Open an issue](https://github.com/rylagek/pack_everything/issues/new/choose) to request development on the desired OS
