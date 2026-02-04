# Complete Example

This example demonstrates how to use the `ecs-and-deepseek-build-personal-website` module to deploy a complete DeepSeek AI personal website solution.

## Usage

1. Clone this repository and navigate to this example directory:
   ```bash
   cd examples/complete
   ```

2. Copy the example configuration file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Edit the `terraform.tfvars` file and provide the required values:
   ```hcl
   # Required variables
   instance_password = "YourSecurePassword123!"
   bailian_api_key  = "your-bailian-api-key"

   # Optional variables (you can customize these)
   region         = "cn-hangzhou"
   instance_type  = "ecs.e-c1m1.large"
   ```

4. Initialize and apply the Terraform configuration:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

5. After deployment, you can access your DeepSeek AI website using the URL provided in the output `demo_url`.

## Prerequisites

- Alibaba Cloud account with appropriate permissions
- Bailian API key (obtain from [Alibaba Cloud Model Studio](https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key))
- Terraform >= 1.0
- Alibaba Cloud Terraform Provider >= 1.212.0

## What This Example Creates

This example creates the following resources:

- **VPC**: A virtual private cloud with CIDR block 192.168.0.0/16
- **VSwitch**: A virtual switch within the VPC with CIDR block 192.168.0.0/24
- **Security Group**: Security group with rules allowing HTTP traffic on port 8080
- **ECS Instance**: An Elastic Compute Service instance to host the DeepSeek AI application
- **RAM User**: A Resource Access Management user for the solution
- **ECS Command**: A command to install and configure the DeepSeek AI application
- **ECS Invocation**: Execution of the installation command on the ECS instance

## Important Notes

- The ECS instance password must be 8-30 characters and contain uppercase letters, lowercase letters, numbers, and special characters
- The Bailian API key is required for the DeepSeek AI service to function
- The installation script will be automatically executed after the ECS instance is created
- It may take several minutes for the application to be fully installed and ready

## Accessing the Application

After successful deployment:

1. Use the `demo_url` output to access your DeepSeek AI website
2. Use the `ecs_login_url` output to access the ECS console for management
3. The application will be available on port 8080 of your ECS instance's public IP

## Clean Up

To destroy the created resources:

```bash
terraform destroy
```

## Troubleshooting

- If the application is not accessible immediately after deployment, wait a few minutes for the installation to complete
- Check the ECS instance logs through the Alibaba Cloud console if needed
- Ensure your Bailian API key is valid and has the necessary permissions