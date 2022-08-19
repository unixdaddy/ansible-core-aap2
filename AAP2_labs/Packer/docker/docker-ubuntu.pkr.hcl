packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
        # if you using podman either comment out previous line
        # AND 
        # uncomment this next line instead
        #source  = "github.com/Polpetta/podman"
      #OR 
        # leave source as docker 
        # AND 
        # execute the following command as root
        #sudo ln -s /usr/bin/podman /usr/bin/docker
    }
  }
}

source "docker" "ubuntu-xenial" {
  image  = "ubuntu:xenial"
  commit = true
}

source "docker" "ubuntu-zesty" {
  image  = "ubuntu:zesty"
  commit = true
}

build {
  name = "learn-packer-xenial"
  sources = [
    "source.docker.ubuntu-xenial"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world from xenial",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
}

  build {
  name = "learn-packer-zesty"
  sources = [
    "source.docker.ubuntu-zesty"
  ]
  provisioner "shell" {
    environment_vars = [
      "FOO=hello world from zesty",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
}
