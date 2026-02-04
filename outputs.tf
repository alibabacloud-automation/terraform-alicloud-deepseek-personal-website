# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

# VSwitch Outputs
output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_cidr_block" {
  description = "The CIDR block of the VSwitch"
  value       = alicloud_vswitch.vswitch.cidr_block
}

# Security Group Outputs
output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.security_group.id
}

# ECS Instance Outputs
output "instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.ecs_instance.id
}

output "instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.primary_ip_address
}

# RAM User Outputs
output "ram_user_name" {
  description = "The name of the RAM user"
  value       = alicloud_ram_user.user.name
}

# ECS Command Outputs
output "ecs_command_id" {
  description = "The ID of the ECS command"
  value       = alicloud_ecs_command.install_app.id
}

# Application Access URL
output "demo_url" {
  description = "The URL to access the DeepSeek AI application"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}:8080"
}

# ECS Console Login URL
output "ecs_login_url" {
  description = "The URL to login to ECS console"
  value       = "https://ecs-workbench.aliyun.com/?instanceType=ecs&regionId=${local.region_id}&instanceId=${alicloud_instance.ecs_instance.id}"
}
