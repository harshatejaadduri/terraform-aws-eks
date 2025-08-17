variable "public_subnet" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "project" {
  default = "k8-roboshop"
}

variable "environment" {
  default = "dev"
}