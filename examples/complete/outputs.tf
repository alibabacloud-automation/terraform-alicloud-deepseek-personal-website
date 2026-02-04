# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.deepseek_website.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.deepseek_website.vpc_cidr_block
}

# VSwitch Outputs
output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.deepseek_website.vswitch_id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch"
  value       = module.deepseek_website.vswitch_cidr_block
}

# Security Group Outputs
output "security_group_id" {
  description = "The ID of the security group"
  value       = module.deepseek_website.security_group_id
}

# ECS Instance Outputs
output "instance_id" {
  description = "The ID of the ECS instance"
  value       = module.deepseek_website.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.deepseek_website.instance_public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = module.deepseek_website.instance_private_ip
}

# RAM User Outputs
output "ram_user_name" {
  description = "The name of the RAM user"
  value       = module.deepseek_website.ram_user_name
}

# ECS Command Outputs
output "ecs_command_id" {
  description = "The ID of the ECS command"
  value       = module.deepseek_website.ecs_command_id
}

# Application Access URL
output "demo_url" {
  description = "The URL to access the DeepSeek AI application"
  value       = module.deepseek_website.demo_url
}

# ECS Console Login URL
output "ecs_login_url" {
  description = "The URL to login to ECS console"
  value       = module.deepseek_website.ecs_login_url
}