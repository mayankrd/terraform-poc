# Terraform POC
Terraform - Infrastructure as Code boilerplate for AWS as cloud service provider 

This code builds an AWS infrastructure having:

- #### 1 IAM role for executing Lambda Functions
- #### 2 EC2 t2.micro instances
- #### 1 AWS Dynamo DB table titled 'TerraGameScores_v1' having 3 attributes and a global secondry index
- #### Uploads a set of Lambda Functions defined in zip file 'lambda_function_payload'

## Getting Started

###### 1. Update provider details in example.tf file with your AWS credentials:

```
provider "aws" {
  region     = "us-east-1"
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
}
```
###### 2. Execute following commands to plan and deploy resources
``` 
terraform init
terraform plan
terraform apply // warning: this step will allocate AWS resources and may incur cost 
```

## Deployment

Use following commands to better understand the state of the cloud infrastructure.
Commands to be executed in format: ``` terraform init ```

###### Initial planning and deployment commands:
```
    init               Initialize a new or existing Terraform configuration
    plan               Generate and show an execution plan
    apply              Builds or changes infrastructure
```

###### Terraform state management commands:
```
    destroy            Destroy Terraform-managed infrastructure
    output             Read an output from a state file
    providers          Prints a tree of the providers used in the configuration
    push               Upload this Terraform module to Terraform Enterprise to run
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    validate           Validates the Terraform files
    version            Prints the Terraform version

```

## Built With

* [Terraform](https://www.terraform.io/) - Write, Plan, and Create Infrastructure as Code
* [HCL language support](https://plugins.jetbrains.com/plugin/7808-hcl-language-support) - This plugin adds support for HashiCorp Configuration Language (HCL) and HashiCorp Interpolation Language (HIL) languages

## Contributing

Please feel free to add sample infrastucture using other cloud platforms like Google Cloud, Microsoft Azure, etc.

## Acknowledgments

* Terraform documentation & guides

