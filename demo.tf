provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA2XKIDBHGSMQMDURO"
  secret_key = "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"
}

  provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2XKIDBHGSMQMDURO"
  secret_key = "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"
  alias="useast1"
}

  resource "aws_instance" "us-east-2" {
  ami           = "ami-0443305dabd4be2bc"
  instance_type = "t2.micro"
}

  resource "aws_instance" "us-east-1" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  provider=aws.useast1
}

resource "aws_s3_bucket" "myfirstbucket" {
  bucket = "s3-gvr-bucket-terradorm7"
  acl    = "private"

  tags = {
    Name        = "My terraform bucket"
    Environment = "Dev"
  }
  versioning{
       enabled=true
       }
}

resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "dev-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dev-subnet"
  }
}

resource "aws_db_instance" "projectdbs" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.19"
  instance_class       = "db.t2.micro"
  name                 = "myterraformdb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}



