variable "region" {
  type        = string
  description = "The Alibaba Cloud region where resources will be created"
  default     = "cn-zhangjiakou"
}


variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default     = null
}

variable "vswitch_cidr_block" {
  type        = string
  description = "The CIDR block for the VSwitch"
  default     = "192.168.0.0/24"
}

variable "vswitch_name" {
  type        = string
  description = "The name of the VSwitch"
  default     = null
}

variable "security_group_name" {
  type        = string
  description = "The name of the security group"
  default     = null
}

variable "security_group_description" {
  type        = string
  description = "The description of the security group"
  default     = "Security group for DeepSeek AI website"
}

variable "security_group_rule_config" {
  description = "The parameters of security group rules."
  type = list(object({
    type        = string
    ip_protocol = string
    nic_type    = string
    policy      = string
    port_range  = string
    priority    = number
    cidr_ip     = string
  }))
  default = [{
    type        = "ingress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "accept"
    port_range  = "8080/8080"
    priority    = 1
    cidr_ip     = "192.168.0.0/24"
  }]
}

variable "image_id" {
  type        = string
  description = "The image ID for the ECS instance"
  default     = "aliyun_3_x64_20G_alibase_20250117.vhd"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the ECS instance"
  default     = "ecs.e-c1m1.large"
}

variable "ecs_instance_password" {
  type        = string
  description = "The password for the ECS instance (8-30 characters, must contain uppercase, lowercase, number and special character)"
  sensitive   = true
}

variable "instance_name" {
  type        = string
  description = "The name of the ECS instance"
  default     = null
}

variable "system_disk_category" {
  type        = string
  description = "The system disk category"
  default     = "cloud_essd"
}

variable "internet_max_bandwidth_out" {
  type        = number
  description = "The maximum outbound bandwidth for the ECS instance"
  default     = 10
}

variable "ram_user_name" {
  type        = string
  description = "The name of the RAM user"
  default     = null
}

variable "ecs_command_name" {
  type        = string
  description = "The name of the ECS command"
  default     = "install-deepseek-app"
}

variable "bailian_api_key" {
  type        = string
  description = "The Bailian API key for DeepSeek service. Get it from https://help.aliyun.com/zh/model-studio/developer-reference/get-api-key"
  sensitive   = true
}

variable "ecs_command_working_dir" {
  type        = string
  description = "The working directory for the ECS command"
  default     = "/root"
}

variable "ecs_command_type" {
  type        = string
  description = "The type of the ECS command"
  default     = "RunShellScript"
}

variable "ecs_command_timeout" {
  type        = number
  description = "The timeout for the ECS command in seconds"
  default     = 3600
}

variable "ecs_invocation_timeout" {
  type        = string
  description = "The timeout for the ECS invocation"
  default     = "15m"
}