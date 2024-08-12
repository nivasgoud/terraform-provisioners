terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.60.0"
    }
  }

#   backend "s3" {
#     # bucket = "nivas-terraformlock"
#     # key    = "statelock"
#     # region = "us-east-1"
#     # dynamodb_table = "roboshop-lock"
#   }

}

provider "aws" {
  region = "us-east-1"
}
