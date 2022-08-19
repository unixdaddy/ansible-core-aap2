packer {
  required_plugins {
    # hashicorp official  
    amazon = {
      version = ">= 1.0.9"
      source = "github.com/hashicorp/amazon"
    }
    # community plugin
    git = {
      version = ">= 0.3.0"
      source = "github.com/ethanmdavidson/git"
    }
  }
}
