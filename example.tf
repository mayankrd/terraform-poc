# -------------------------------------------------------------------------------
# Provider : AWS
# -------------------------------------------------------------------------------
provider "aws" {
  region     = "us-east-1"
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
}


# -------------------------------------------------------------------------------
# AWS EC2 instance
# Ubuntu 14.04 LTS AMI : ami-0d729a60
# Ubuntu 16.04 LTS AMI : ami-13be557e
# -------------------------------------------------------------------------------
resource "aws_instance" "example_ec2_2" {
  ami           = "ami-13be557e"
  instance_type = "t2.micro"
}


# -------------------------------------------------------------------------------
# AWS EC2 instance
# -------------------------------------------------------------------------------
resource "aws_instance" "example_ec2_3" {
  ami           = "ami-0d729a60"
  instance_type = "t2.micro"
}


# -------------------------------------------------------------------------------
# AWS IAM Role
# -------------------------------------------------------------------------------
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_demo"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


# -------------------------------------------------------------------------------
# AWS DynamoDB Table
# -------------------------------------------------------------------------------
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "TerraGameScores_v1"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}


# -------------------------------------------------------------------------------
# AWS Lambda
# -------------------------------------------------------------------------------
resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda_function_payload.zip"
  function_name    = "terraDemoGetAllRecs"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "handler.terraDemoGetAllRecs"
  source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  runtime = "nodejs4.3"

  environment {
    variables = {
      foo = "bar"
    }
  }
}