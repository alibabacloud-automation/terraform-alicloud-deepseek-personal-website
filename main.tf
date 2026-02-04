# Create VPC
resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_config.cidr_block
  vpc_name   = var.vpc_config.vpc_name
}

# Create VSwitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vswitch_config.cidr_block
  zone_id      = var.vswitch_config.zone_id
  vswitch_name = var.vswitch_config.vswitch_name
}

# Create Security Group
resource "alicloud_security_group" "security_group" {
  vpc_id              = alicloud_vpc.vpc.id
  security_group_name = var.security_group_config.security_group_name
  description         = var.security_group_config.description
}

# Create Security Group Rules
resource "alicloud_security_group_rule" "security_group_rule" {
  for_each          = { for i, rule in var.security_group_rule_config : i => rule }
  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.security_group.id
  cidr_ip           = each.value.cidr_ip
}

# Create ECS Instance
resource "alicloud_instance" "ecs_instance" {
  instance_name              = var.instance_config.instance_name
  system_disk_category       = var.instance_config.system_disk_category
  image_id                   = var.instance_config.image_id
  vswitch_id                 = alicloud_vswitch.vswitch.id
  password                   = var.instance_config.password
  instance_type              = var.instance_config.instance_type
  internet_max_bandwidth_out = var.instance_config.internet_max_bandwidth_out
  security_groups            = [alicloud_security_group.security_group.id]
}

# Create RAM User
resource "alicloud_ram_user" "user" {
  name = var.ram_user_config.name
}

data "alicloud_regions" "current" {}

locals {
  region_id = data.alicloud_regions.current.regions[0].id

  default_install_script = <<EOF
#!/bin/bash
cat <<EOT >> ~/.bash_profile
export API_KEY="${var.bailian_api_key}"
export ROS_DEPLOY=true
EOT

source ~/.bash_profile
curl -fsSL https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/install-script/deepseek-r1-private/install.sh|bash
EOF
}

# Create ECS Command for application installation
resource "alicloud_ecs_command" "install_app" {
  name = var.ecs_command_config.name
  command_content = base64encode(
    var.custom_install_script != null ? var.custom_install_script : local.default_install_script
  )
  working_dir = var.ecs_command_config.working_dir
  type        = var.ecs_command_config.type
  timeout     = var.ecs_command_config.timeout
}

# Execute ECS Command
resource "alicloud_ecs_invocation" "invoke_script" {
  instance_id = [alicloud_instance.ecs_instance.id]
  command_id  = alicloud_ecs_command.install_app.id
  timeouts {
    create = var.ecs_invocation_config.timeout_create
  }
}