variable ami {

    type = string
    default = "ami-0b4f379183e5706b9"
}

variable inst_type {

    type = string
    default = "t2.micro"
}

variable subnet {

    type = string
    default = "subnet-0ac3df5627209a411"
}

variable name {

    type = string
    default = "Roboshop-provisioner"
}

variable terraform_sg {
    type = string
    default = "roboshop_sg_terraform"
}

variable terraform_sg_desc {
    type = string
    default = "Allow TLS inbound traffic and all outbound traffic"
}

variable roboshop_vpc {
    type = string
    default = "vpc-04bd12716aff5c06f"
}