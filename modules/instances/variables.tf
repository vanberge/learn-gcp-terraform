variable "project_id" { 
    default = "<project id>"    
}

variable "region" {
    default = "us-central1"
}

variable "zone" {
    default = "us-central1-c"
}

#call the variable to be passed in by network module
variable "vpc_network"{
    type = string
}