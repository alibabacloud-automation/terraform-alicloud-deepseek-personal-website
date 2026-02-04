provider "alicloud" {
  region = var.region
}

# Data sources to get available zones and instance types
data "alicloud_zones" "available" {
  available_instance_type     = var.instance_type
  available_disk_category     = var.system_disk_category
  available_resource_creation = "VSwitch"
}

# Module usage
module "deepseek_website" {
  source = "../../"

  vpc_config = {
    cidr_block = var.vpc_cidr_block
    vpc_name   = var.vpc_name
  }

  vswitch_config = {
    cidr_block   = var.vswitch_cidr_block
    zone_id      = data.alicloud_zones.available.zones[0].id
    vswitch_name = var.vswitch_name
  }

  security_group_config = {
    security_group_name = var.security_group_name
    description         = var.security_group_description
  }

  security_group_rule_config = var.security_group_rule_config

  instance_config = {
    image_id                   = var.image_id
    instance_type              = var.instance_type
    password                   = var.ecs_instance_password
    instance_name              = var.instance_name
    system_disk_category       = var.system_disk_category
    internet_max_bandwidth_out = var.internet_max_bandwidth_out
  }

  ram_user_config = {
    name = var.ram_user_name
  }

  ecs_command_config = {
    name        = var.ecs_command_name
    working_dir = var.ecs_command_working_dir
    type        = var.ecs_command_type
    timeout     = var.ecs_command_timeout
  }
  bailian_api_key = var.bailian_api_key

  ecs_invocation_config = {
    timeout_create = var.ecs_invocation_timeout
  }
}