#####################################
### Required GitHub Configuration ###
#####################################

variable "github_token" {
  default     = "*********************************"
  description = "Your GitHub Personal Access Token"
}

variable "files" {
  default = ["bookstore-api.py", "requirements.txt", "Dockerfile", "docker-compose.yml"]
}

variable "github_repository_name" {
  default = "terraform-bookstore-api"
}
variable "github_repository_branch_name" {
  default = "main"
}

variable "github_commit_message" {
  default = "Created by Terraform"
}

####################################
#### Required AWS Configuration ####
####################################

variable "region" {
  default     = "us-east-1"
  description = "The region where the instance will be created"
}

variable "profile" {
  default = "default"
}

########################################
# Required AWS Resources Configuration #
########################################

variable "key_name" {
  default     = "east1"
  description = "The name of the key pair to use for SSH access to the instance."
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_ami" {
  default = "ami-0f9fc25dd2506cf6d"
}

variable "instance_name" {
  default = "Web Server of Bookstore"
}

variable "security_group_name" {
  default = "docker-sec-gr"
}
