output "website_url" {
  value = "http://${aws_instance.tf-docker-instance.public_dns}"
}

output "instance_public_ip" {
  value = "http://${aws_instance.tf-docker-instance.public_ip}"
}

output "github_repository_url" {
  value = github_repository.my_repo.html_url
}
