# Terraform CrossAccountRole
## Basic information
This terraform module consists of two submodules. One for the source-account, from which the role will be assumed and 
one for the target-account, in which the role has to exist.

Usually the terraform code of both accounts will reside in different projects/folders. Also to avoid problems with 
terraform when using multiple providers with different credentials, we split up the module on per account basis.

## Usage
To be able to assume a role in a target-account form a source-account, on both sides some resources have to exist.
For both sides we created a submodule residing in the folders ```source_account``` and ```target_account```.

### Target Account
The target-account is the account where your role exists which will be assumed by a group-member in the 
source-account.

#### Variables
- ```policy_name```: Name of the policy that will be created
- ```policy_json```: The json-representation of the policy. This has to be injected from the outside, since there is no
useful default value that could be created. You can just define your custom policy outside of the module and inject the
resulting JSON with this variable.
- ```role_description```: optional variable to provide a description of the role. Default value is just 'Role for Cross Account Access'
- ```role_name```: name of the role that will be created. 

#### Example Usage
Within the terraform code of your source account you can just use our submodule to create all necessary resources.
But you will have to create a ```aws_iam_policy_document```, so its JSON can be used for the variable ```policy_json```
```hcl-terraform
module "your_choice_of_name" {
    source = "git::ssh://git@github.com:solutionDrive/terraform-cross-account-role.git//target_account?ref=master"
    policy_name = "NameForThePolicy"
    policy_json = "${data.aws_iam_policy_document.s3_list_access.json}"
    role_description = "Role that grants administrative access to the subAccount"
    role_name = "CrossDevOpsRole"
    source_account_id = "${var.solutiondrive_account_id}"
}

data "aws_iam_policy_document" "s3_list_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::your-bucket-name/*"
    ]
  }
}
```
