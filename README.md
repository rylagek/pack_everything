# pack_everything
Generic [Packer](https://www.packer.io/docs) Templates with [chained builders](https://medium.com/swlh/chaining-machine-image-builds-with-packer-b6fd99e35049) for [Vagrant](https://www.packer.io/docs/builders/vagrant), [VirtualBox](https://www.packer.io/docs/builders/virtualbox/iso), [VMWare](https://www.packer.io/docs/builders/vmware/iso), and [vSphere](https://www.packer.io/docs/builders/vsphere/vsphere-iso)

## OS List
### \*Nix in Order of Priority
- Ubuntu 20.04 Desktop
- Ubuntu 20.04 Server
- Rocky Linux
- Kali Linux
- TrueNAS
- Security Onion
- SIFT
- pfSense Router
- Arch
- FreeBSD
- busybox
- Oracle Solaris
- Raspberry Pi OS
- TAILS
- Ubuntu 16.04 Desktop
- Ubuntu 16.04 Server
- REMNUX
- Qubes OS
- OpenBSD
- Parrot
- PureOS
- Gentoo
- Pentoo
- Debian 11


### Windows in Order of Priority
- Windows 10
- Windows Server 2k19
- Windows Vista
- Windows 7
- Windows XP
- Windows Server 2k12


## File Structure
```
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
