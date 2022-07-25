### VCenter Variables ###

variable "vcenter_server"{
    type = string
    description = "vcenter hostname"
}

variable "vcenter_username"{
    type = string
    description = "Username to log into vcenter with"
}

variable "vcenter_password"{
    type = string
    description = "Password to log into vcenter with"
    sensitive = true
}

variable "vcenter_datacenter"{
    type = string
    description = "Datacenter we need to connect to"
    default = "DUCKNet DEVELOPMENT"
}

variable "vcenter_host"{
    type = string
    description = "The host to access the resource pool from"
}

variable "vcenter_datastore"{
    type = string
    description = "The datastore to place the VM Template in"
}

### Location Configuration ###

variable "template_name"{
    type = string
    description = "Name of the VM to create"
}

variable "vcenter_folder"{
    type = string
    description = "Folder to place our template into"
}

variable "iso_paths"{
    type = list(string)
    description = "Path to the ISO on your local computer."
}


### Hardware Configuration ###

variable "num_cpus"{
    type = number
    description = "Number of CPUs to assign the template"
    default = 1

}

variable "ram"{
    type = number
    description = "Amout of RAM to give the template in MB"
    default = 2048

}

variable "disk_size"{
    type = number
    description = "Size of our disk  in MB"
    default = 8192
}

variable "network"{
    type = string
    description = "The network for the default NIC, can be changed later with Terraform"
    default = "2560-10.60.0.0/24"
}


### FreeBSD Variables ###
variable "ssh_username" {
    type = string
    description = "Username used to access the VM after it is configured"
}

variable "ssh_password" {
    type = string
    description = "Password used to access the VM after it is configured."
    sensitive=true
}

variable "ssh_wait_time" {
    type = string
    description = "Timeout on ssh connection"
    default = "10000s"
}

