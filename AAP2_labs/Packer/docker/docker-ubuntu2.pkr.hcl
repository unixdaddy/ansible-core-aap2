packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
      #source  = "github.com/Polpetta/podman"
    }
  }
}

variable "docker_image" {
  type    = string
  default = "ubuntu:xenial"
}

variable "docker_image_zesty" {
  type    = string
  default = "ubuntu:zesty"
}

source "docker" "ubuntu" {
  image  = var.docker_image
  commit = true
}

source "docker" "ubuntu-zesty" {
  image  = var.docker_image_zesty
  commit = true
}

build {
  name = "learn-packer"
  sources = [
    "source.docker.ubuntu",
    "source.docker.ubuntu-zesty"
  ]

  provisioner "shell" {
    environment_vars = [
      "FOO=hello world.",
    ]
    inline = [
      "echo Adding file to Docker Container",
      "echo \"FOO is $FOO\" > example.txt",
    ]
  }
  provisioner "shell" {
    inline = ["echo Running ${var.docker_image} Docker image."]
  }

# post-processor "manifest" {}
  post-processor "docker-tag" {
    repository = "localhost/ubuntu"
    only = ["docker.ubuntu"]
  }

  post-processor "docker-tag" {
    repository = "localhost/ubuntu-zesty"
    only   = ["docker.ubuntu-zesty"]
  }
}
