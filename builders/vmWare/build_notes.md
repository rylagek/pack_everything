# Build Notes:
- All VMs here were built (or attempted) in VMware Workstation Player
- Issues/possible fixes in comments below each VM

---

### Kali Linux: 
- In order to get this to work without using a preseed served over http, a custom kali iso was built that contains the preseed in the root directory of the installation media. 
- The folder containing the tooling to create the iso is included in the `live-build-config` folder.
- The iso is mostly unmodified. There are 2 files of note:
  - `kali-config/common/includes.installer` contains the custom `preseed.cfg` that automates the installation for us
  - `kali-config/common/hooks/01-start-ssh.chroot` is needed to start SSH so that packer can connect
- The iso build is done using the `build.sh` script.
  - To run a standard build with logging do `./build.sh -v`
  - To run a build of a pre-configured kali light (e.g. 'light') do `./build.sh --variant [variant_name] --verbose`. You can see the available variants in the `kali-config` directory. You can also create a custom variant to build in this directory.
  - The iso build will take quite a while. If you are running multiple builds in succession, it's recommended to cache the downloads that the tooling makes. [Squid](http://www.squid-cache.org/)

   ```
    # Getting squid
    apt-get install squid
    # squid.conf is included in the live-build-config directory
    cp squid.conf /etc/squid/squid.conf
    /etc/init.d/squid start
    # Running the build with caching
    export http_proxy=http://localhost:3128/
    ./build.sh --verbose --variant custom -- \
        --apt-http-proxy=${http_proxy}
    ```  

  - Kali recommends building the iso from within a kali environment. In my case, I spun up a kali vm and worked from inside that, and used the shared folder feature of VirtualBox to transfer files between the VM and the host I was running builds from.

### Ubuntu 20.04 Server: 
- Functional and boots normally
- Boot wait is tricky - needs to be low enough to send input before defaults are used
  - On a 2019 Thinkpad running Manjaro, 2s was too low and 5 seconds is close to the high bound
- Despite the `stop ssh` command, still require a large `ssh_timeout` and `ssh_handshake_attempts` so packer doesn't timeout while system is updating
