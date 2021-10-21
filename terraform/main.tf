terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
    bucket = "arena123"
    key    = "terraform-webserver.tfstate"
    region = "us-east-1"
  }
}

resource "null_resource" "provision_master"{
  depends_on = ["openstack_compute_volume_attach_v2.jenkins_store_attach"]
  provisioner "local-exec" {
    command       = "ansible-playbook jenkins.yml"
    working_dir   = "../ansible"
  }
}