variable "region" {
  description = "AWS region to deploy resources"
  default     = "eu-north-1"
}

variable "frontend_bucket_name" {
  description = "Name of S3 bucket for frontend static website hosting"
  default     = "blog-app-frontend-bucket"
}

variable "media_bucket_name" {
  description = "Name of S3 bucket for media storage"
  default     = "blog-app-media-bucket"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance (Ubuntu 22.04)"
  default     = "ami-0c1ac8a41498c1a9c" # Ubuntu 22.04 LTS in eu-north-1
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "firstkey" # Replace with your key pair name
} 