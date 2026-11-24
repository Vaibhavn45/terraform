terraform {
    backend "s3" {
     bucket = "vaibhavc-sf"
     region = "us-est-2"
     key = "tfstate-file"
    }
}