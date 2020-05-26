terraform {
  backend "s3" {
    bucket         = "terraform-state-1122334455-us-west-2-dev" # IE: terraform-state-112233445566-us-west-2-dev
    key            = "us-west-2/dev/stacks/demo/terraform.tfstate" # variable notation expanded by terraspace IE: us-west-2/dev/modules/vm/terraform.tfstate
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform_locks"
  }
}
