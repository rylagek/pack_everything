# Build Notes:
- All VMs here were built (or attempted) in VirtualBox
- Issues/possible fixes in comments below each VM
- VMs that we have tried but have yet to boot (see comments and issues for reasoning):
  - Security Onion (loads image, but does not fully boot due to SSH password errors)
  - SIFT (unable to load from URL on SANS website; likely boots fine but syntax errors prevent it from loading from a local file path)
  - FreeBSD (loads image, some kind of install fails and prevents it from booting properly)

---

### Kali Linux: 
- Fully functional; boots normally

### Ubuntu 18.04 Desktop:
- Fully functional; boots normally

### Ubuntu 20.04 Desktop: 
- Pivoted to attempting to install `ubuntu-desktop` package onto a working server build
- Doesn't seem to work - build is successful, but the resultant VM just displays a black screen and can't be interacted with
- TODO - once/if the above is resolved, break the installation of `ubuntu-desktop` into a chained builder that uses the output of the ubuntu\_server build

### Ubuntu 20.04 Server: 
- Functional and boots normally
- Now uses cloud-init
- Boot wait is tricky - needs to be low enough to send input before defaults are used
  - On a 2019 Thinkpad running Manjaro, 2s was too low and 5 seconds is close to the high bound
- Despite the `stop ssh` command, still require a large `ssh_timeout` and `ssh_handshake_attempts` so packer doesn't timeout while system is updating

### Rocky Linux: 
- Fully functional; boots normally

### TrueNAS: 
- Fully functional; boots normally
- WebUI can be accessed for further configuration. Networking config is platform dependent. Easiest for students is to import the vm and set networking to bridged
- Alternative to WebUI is RESTful api. This can be used from the box itself or remotely via `http://[localhost | IP]/api/v2.0/`. The documentation can be accessed via `http://[localhost | IP]/api/docs/`
  - If using `curl` you can authorize to the API using `-u root:truenas`
- SSH creds are `root:truenas`

### Security Onion:
- Loads an image
- Requires min 99GB for install (will likely need more for operation)
- 2 NIC "required", but can run with 1
- 4 Cores/12 GB memory required
- SSH Password issues (minimize.sh?)

### SIFT: 
- Easy to download from SANS, but link is not copyable (checksum is present though) - recommend downloading the SIFT VM and using a local filepath to boot it up instead of the usual URL method (has not been successful to date, likely due to syntax errors)

### pfSense:
- Boots, but checks to see if WAN link is up

### Arch:
- Fully functional; boots normally
- `ssh_handshake_attempts` is set to a stupidly large amount. I think the iso itself might have ssh, so packer attempts to connect to that and gets rejected, so for now I've set the number of attempts to a very large value.
- Installs `base, linux, linux-firmware`
- Can write some provisioners if there's some barebones configuration that would be useful

### FreeBSD:
- Image loads; install fails (can't find folder/file, so it doesn't boot)
- SSH errors

### Windows 10:
- Image loads; starts winrm (is listening); starts updates.
- Does not connect to winrm

### Windows Server 2019:
- Fully functional as long as commands to install/start SSH are input once the machine loads (see txt file in folder for details; the sshstarter script does not work since the machine reboots for update purposes and erases the changes made by the script)
- Boots from a local copy of the iso, not a url
  - UPDATE 20 JAN 2022: Added .pkr.hcl file that uses winrm instead of ssh. Fully functional; no extra commands are necessary upon booting, unlike SSH.
  - sshstarter file not necessary unless you want to run a provisioner to install/enable OpenSSH and create a host firewall rule to allow SSH traffic
  - Super helpful github repository below - useful if you need to switch between bios/uefi or Windows Server 2019 Core/GUI versions (see link below). Default code for these templates contains vmware and virtual box code by default, so it works whether you use vbox (like I did) or vmware.
- https://github.com/eaksel/packer-Win2019
