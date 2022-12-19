packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "packer-ami-aarsh" {
    ami_name = "packer-nodejs-aarsh"
    source_ami = "ami-0530ca8899fac469f"
    instance_type = "t3a.small"
    region = "us-west-2"
    ssh_username = "ubuntu"
    iam_instance_profile = "role-aarsh"
}

build {
    sources = [
        "source.amazon-ebs.packer-ami-aarsh"
    ]

    provisioner "shell" {
        script = "./ami.sh"
    }
}
