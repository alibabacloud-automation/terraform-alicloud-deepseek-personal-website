阿里云 DeepSeek AI 个人网站 Terraform 模块

# terraform-alicloud-deepseek-personal-website

[English](https://github.com/alibabacloud-automation/terraform-alicloud-deepseek-personal-website/blob/main/README.md) | 简体中文

本示例用于实现解决方案[低成本搭建 DeepSeek 专属 AI 网站](https://www.aliyun.com/solution/tech-solution/ecs-and-deepseek-build-personal-website)，涉及到专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）、RAM 用户等资源的创建。这是一个用于在阿里云上部署 DeepSeek AI 个人网站的完整基础设施解决方案的 Terraform 模块，该模块提供所有必要的资源，包括 VPC、ECS 实例、安全组，并自动安装和配置 DeepSeek AI 应用程序。我们的开发过程利用了专门的自动化工具和代理，以确保跨所有基础设施组件的一致性、可靠部署并保持最佳实践。

## 使用方法

该模块创建用于托管 DeepSeek AI 个人网站的完整基础设施堆栈。它包括网络设置、计算资源、安全配置和自动化应用程序部署。

```terraform
module "deepseek_website" {
  source = "alibabacloud-automation/deepseek-personal-website/alicloud"

  # VPC 配置
  vpc_config = {
    cidr_block = "192.168.0.0/16"
    vpc_name   = "deepseek-vpc"
  }

  # 交换机配置
  vswitch_config = {
    cidr_block   = "192.168.0.0/24"
    zone_id      = "cn-hangzhou-f"
    vswitch_name = "deepseek-vsw"
  }

  # 安全组配置
  security_group_config = {
    security_group_name = "deepseek-sg"
    description         = "DeepSeek AI 网站的安全组"
  }

  # 安全组规则配置 (对象列表)
  security_group_rule_config = [{
    type        = "ingress"
    ip_protocol = "tcp"
    nic_type    = "intranet"
    policy      = "accept"
    port_range  = "8080/8080"
    priority    = 1
    cidr_ip     = "0.0.0.0/0"
  }]

  # ECS 实例配置
  instance_config = {
    image_id                   = "aliyun_3_x64_20G_alibase_20250117.vhd"
    instance_type              = "ecs.e-c1m1.large"
    password                   = "YourSecurePassword123!"
    instance_name              = "deepseek-ecs"
    system_disk_category       = "cloud_essd"
    internet_max_bandwidth_out = 10
  }

  # RAM 用户配置
  ram_user_config = {
    name = "deepseek-user"
  }

  # ECS 命令配置
  ecs_command_config = {
    name        = "install-deepseek-app"
    working_dir = "/root"
    type        = "RunShellScript"
    timeout     = 3600
  }

  # ECS 调用配置
  ecs_invocation_config = {
    timeout_create = "15m"
  }

  # DeepSeek AI 配置
  bailian_api_key = "your-bailian-api-key"

  # 可选的自定义安装脚本
  # custom_install_script = "your-custom-install-script-here"
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-deepseek-personal-website/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.install_app](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.invoke_script](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_ram_user.user](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.security_group_rule](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_regions.current](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/regions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bailian_api_key"></a> [bailian\_api\_key](#input\_bailian\_api\_key) | The API key for Bailian service | `string` | n/a | yes |
| <a name="input_custom_install_script"></a> [custom\_install\_script](#input\_custom\_install\_script) | Optional custom installation script to override the default | `string` | `null` | no |
| <a name="input_ecs_command_config"></a> [ecs\_command\_config](#input\_ecs\_command\_config) | The parameters of ECS command. | <pre>object({<br/>    name        = string<br/>    working_dir = string<br/>    type        = string<br/>    timeout     = number<br/>  })</pre> | <pre>{<br/>  "name": "install-deepseek-app",<br/>  "timeout": 3600,<br/>  "type": "RunShellScript",<br/>  "working_dir": "/root"<br/>}</pre> | no |
| <a name="input_ecs_invocation_config"></a> [ecs\_invocation\_config](#input\_ecs\_invocation\_config) | The parameters of ECS invocation. | <pre>object({<br/>    timeout_create = string<br/>  })</pre> | <pre>{<br/>  "timeout_create": "15m"<br/>}</pre> | no |
| <a name="input_instance_config"></a> [instance\_config](#input\_instance\_config) | The parameters of ECS instance. The attributes 'image\_id', 'instance\_type', 'password' are required. | <pre>object({<br/>    image_id                   = string<br/>    instance_type              = string<br/>    password                   = string<br/>    instance_name              = optional(string, "deepseek-ecs")<br/>    system_disk_category       = optional(string, "cloud_essd")<br/>    internet_max_bandwidth_out = optional(number, 10)<br/>  })</pre> | <pre>{<br/>  "image_id": "aliyun_3_x64_20G_alibase_20250117.vhd",<br/>  "instance_name": "deepseek-ecs",<br/>  "instance_type": "ecs.e-c1m1.large",<br/>  "internet_max_bandwidth_out": 10,<br/>  "password": null,<br/>  "system_disk_category": "cloud_essd"<br/>}</pre> | no |
| <a name="input_ram_user_config"></a> [ram\_user\_config](#input\_ram\_user\_config) | The parameters of RAM user. | <pre>object({<br/>    name = optional(string, "deepseek-user")<br/>  })</pre> | <pre>{<br/>  "name": "deepseek-user"<br/>}</pre> | no |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | The parameters of security group. | <pre>object({<br/>    security_group_name = optional(string, "deepseek-sg")<br/>    description         = optional(string, "Security group for DeepSeek AI website")<br/>  })</pre> | n/a | yes |
| <a name="input_security_group_rule_config"></a> [security\_group\_rule\_config](#input\_security\_group\_rule\_config) | The parameters of security group rules. | <pre>list(object({<br/>    type        = string<br/>    ip_protocol = string<br/>    nic_type    = string<br/>    policy      = string<br/>    port_range  = string<br/>    priority    = number<br/>    cidr_ip     = string<br/>  }))</pre> | <pre>[<br/>  {<br/>    "cidr_ip": "0.0.0.0/0",<br/>    "ip_protocol": "tcp",<br/>    "nic_type": "intranet",<br/>    "policy": "accept",<br/>    "port_range": "8080/8080",<br/>    "priority": 1,<br/>    "type": "ingress"<br/>  }<br/>]</pre> | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The parameters of VPC. The attribute 'cidr\_block' is required. | <pre>object({<br/>    cidr_block = string<br/>    vpc_name   = optional(string, "deepseek-vpc")<br/>  })</pre> | n/a | yes |
| <a name="input_vswitch_config"></a> [vswitch\_config](#input\_vswitch\_config) | The parameters of VSwitch. The attributes 'cidr\_block' and 'zone\_id' are required. | <pre>object({<br/>    cidr_block   = string<br/>    zone_id      = string<br/>    vswitch_name = optional(string, "deepseek-vsw")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_demo_url"></a> [demo\_url](#output\_demo\_url) | The URL to access the DeepSeek AI application |
| <a name="output_ecs_command_id"></a> [ecs\_command\_id](#output\_ecs\_command\_id) | The ID of the ECS command |
| <a name="output_ecs_login_url"></a> [ecs\_login\_url](#output\_ecs\_login\_url) | The URL to login to ECS console |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the ECS instance |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | The private IP address of the ECS instance |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_ram_user_name"></a> [ram\_user\_name](#output\_ram\_user\_name) | The name of the RAM user |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#output\_vswitch\_cidr\_block) | The CIDR block of the VSwitch |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)