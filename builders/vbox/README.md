This is a text file made to document troubleshooting techniques and other
useful information as it relates to Packer for virtualbox. When adding information
please put in in chronological order based on when a user may have use of a
particular note (ex: notes on creating the VM should come before scripting notes)

Useful Info:

1. The basic steps for running a .pkr.hcl file is to navigate to a directory on
a terminal that contains a directory with the pkr.hcl file in it. Then run
packer build <directory> (in this repository navigate to the OS you desire and
the command will be packer build packer)

2. In a .pkr.hcl file there are at least 2 code blocks. Source is the code block
that will handle the virtualbox creation. Here basic steps are done such as choosing
an ISO, listing your OS type, setting virtual machine resources, and some boot
commands to help automate the process.

3. The second code block is build. This is where scripts and configuration changes
can be run.

4. The build time is listed at the end of every successful and sometimes
unsuccessful builds. Sometimes it takes over 15 minutes for a build to complete.
If it is taking substantially longer consider troubleshooting while you continue
waiting for the build to finish. You may also use ctrl+c to end the process if
it seems like it will not build successfully.


Troubleshooting:

1. Sometimes the build will be stuck on downloading an ISO or performing a
checksum. If this occurs, verify the ISO link if correct along with the
checksum value. You may even download an ISO to reference locally.

2. When testing a build you may find that it will finish in under 10 seconds with
the message "Builds finished but no artifacts were created" This is because there
is already an artifact made for that operating system and you must use a flag to
delete it  prior to building (ex: packer build -force packer)
