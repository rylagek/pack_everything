# Build Notes:
- All VMs here were built (or attempted) in VMware Workstation Player
- Issues/possible fixes in comments below each VM

---

### Kali Linux: 
- Fully functional; boots normally

### Ubuntu 20.04 Server: 
- Functional and boots normally
- Boot wait is tricky - needs to be low enough to send input before defaults are used
  - On a 2019 Thinkpad running Manjaro, 2s was too low and 5 seconds is close to the high bound
- Despite the `stop ssh` command, still require a large `ssh_timeout` and `ssh_handshake_attempts` so packer doesn't timeout while system is updating
