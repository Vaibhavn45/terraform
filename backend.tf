terraform {
    backend "s3" {
     bucket = "vaibhavc-sf"
     region = "us-east-2"
     key = "tfstate-file"
    }
}