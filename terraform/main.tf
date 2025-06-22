module prod-infra {
    source = "./infra-modules"
    environment = "prod"
    instance_count = 1
    instance_type = "t2.micro"
    ami_id = "ami-04f167a56786e4b09"
}

