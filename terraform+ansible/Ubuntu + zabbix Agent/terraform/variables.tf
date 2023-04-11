variable “project” {
  type = string
  description = “Project”
  default = “<PROJECT_ID>”
}

variable “name” {
  type =string
  description = “Instance name”
  default = “instance”
}

Variable “region” {
  type = string
  description = “Region”
  default = “us-central1”
}

variable “zone” {
  type = string
  description = “Zone”
  default  = “us-central1-a” 
}

 variable “network” {
  type = string
  description = “Network”
  default = “my-network”
}
