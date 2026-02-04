
variable "vpc_config" {
  description = "The parameters of VPC. The attribute 'cidr_block' is required."
  type = object({
    cidr_block = string
    vpc_name   = optional(string, "deepseek-vpc")
  })
}

variable "vswitch_config" {
  description = "The parameters of VSwitch. The attributes 'cidr_block' and 'zone_id' are required."
  type = object({
    cidr_block   = string
    zone_id      = string
    vswitch_name = optional(string, "deepseek-vsw")
  })
}

variable "security_group_config" {
  description = "The parameters of security group."
  type = object({
    security_group_name = optional(string, "deepseek-sg")
    description         = optional(string, "Security group for DeepSeek AI website")
  })
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
    cidr_ip     = "0.0.0.0/0"
  }]
}

variable "instance_config" {
  description = "The parameters of ECS instance. The attributes 'image_id', 'instance_type', 'password' are required."
  type = object({
    image_id                   = string
    instance_type              = string
    password                   = string
    instance_name              = optional(string, "deepseek-ecs")
    system_disk_category       = optional(string, "cloud_essd")
    internet_max_bandwidth_out = optional(number, 10)
  })
  default = {
    image_id                   = "aliyun_3_x64_20G_alibase_20250117.vhd"
    instance_type              = "ecs.e-c1m1.large"
    password                   = null
    instance_name              = "deepseek-ecs"
    system_disk_category       = "cloud_essd"
    internet_max_bandwidth_out = 10
  }
}

variable "ram_user_config" {
  description = "The parameters of RAM user."
  type = object({
    name = optional(string, "deepseek-user")
  })
  default = {
    name = "deepseek-user"
  }
}

variable "ecs_command_config" {
  description = "The parameters of ECS command."
  type = object({
    name        = string
    working_dir = string
    type        = string
    timeout     = number
  })
  default = {
    name        = "install-deepseek-app"
    working_dir = "/root"
    type        = "RunShellScript"
    timeout     = 3600
  }
}

variable "bailian_api_key" {
  description = "The API key for Bailian service"
  type        = string
  sensitive   = true
}

variable "custom_install_script" {
  type        = string
  default     = null
  description = "Optional custom installation script to override the default"
}


variable "ecs_invocation_config" {
  description = "The parameters of ECS invocation."
  type = object({
    timeout_create = string
  })
  default = {
    timeout_create = "15m"
  }
}

