resource "github_repository" "my_repo" {
  name        = var.github_repository_name
  description = "Bookstore API Repository"
  auto_init   = true
  visibility  = "private" # The visibility parameter overrides the "private" parameter.
  # private   = true      # (Optional) Set to true to create a private repository. 
}

resource "github_branch_default" "main" {
  branch     = var.github_repository_branch_name
  repository = github_repository.my_repo.name
}

resource "github_repository_file" "app-files" {
  repository          = github_repository.my_repo.name
  branch              = github_branch_default.main.branch
  commit_message      = var.github_commit_message
  for_each            = toset(var.files)
  content             = file(each.value)
  file                = each.value
  overwrite_on_create = true
}

resource "aws_security_group" "tf-docker-sec-gr" {
  name = var.security_group_name

  tags = {
    Name = var.security_group_name
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf-docker-instance" {
  tags = {
    Name = var.instance_name
  }
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  depends_on             = [aws_security_group.tf-docker-sec-gr, github_repository_file.app-files]
  user_data              = file("user-data.sh")
  vpc_security_group_ids = [aws_security_group.tf-docker-sec-gr.id]
}
