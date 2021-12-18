# pack_everything
Generic [Packer](https://www.packer.io/docs) Templates with [chained builders](https://medium.com/swlh/chaining-machine-image-builds-with-packer-b6fd99e35049) for [Vagrant](https://www.packer.io/docs/builders/vagrant), [VirtualBox](https://www.packer.io/docs/builders/virtualbox/iso), [VMWare](https://www.packer.io/docs/builders/vmware/iso), and [vSphere](https://www.packer.io/docs/builders/vsphere/vsphere-iso)

## OS List
### \*Nix in Order of Priority
1) Ubuntu 20.04 Desktop
2) Ubuntu 20.04 Server
3) Rocky Linux
4) Kali Linux
5) TrueNAS
6) Security Onion
7) SIFT
8) pfSense Router
9) Arch
10) FreeBSD
11) busybox
12) Oracle Solaris
13) Raspberry Pi OS
14) TAILS
15) Ubuntu 16.04 Desktop
16) Ubuntu 16.04 Server
17) REMNUX
18) Qubes OS
19) OpenBSD
20) Parrot
21) PureOS
22) Gentoo
23) Pentoo
24) Debian 11


### Windows in Order of Priority
1) Windows 10
2) Windows Server 2k19
3) Windows Vista
4) Windows 7
5) Windows XP
6) Windows Server 2k12


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
