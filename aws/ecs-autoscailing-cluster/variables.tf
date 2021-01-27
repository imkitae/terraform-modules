variable "tags" {
  description = "The tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "ecs_cluster_name" {
  description = "The name of ECS cluster"
  type        = string
  default     = null
}

variable "asg_availability_zones" {
  description = "The availability zones where autoscale group instances are created. Ignore if `asg_subnet_ids` is defined"
  type        = list(string)
  default     = null
}

variable "asg_subnet_ids" {
  description = "The list of subnet IDs associate with autoscale instances. Ignore if `asg_availability_zones` is defined"
  type        = list(string)
  default     = null
}

variable "asg_min_size" {
  description = "The minimum number of autoscale instances."
  type        = number
  default     = 0
}

variable "asg_max_size" {
  description = "The maximum number of autoscale instances."
  type        = number
  default     = 1
}

variable "asg_desired_capacity" {
  description = "The decired number of autoscale instances."
  type        = number
  default     = 0
}

variable "asg_termination_policies" {
  description = "The policies that choose which instance to terminate first"
  type        = list(string)
  default     = ["OldestInstance"]
}

variable "instance_name" {
  description = "The name tag attached to scaled instance"
  type        = string
  default     = null
}

variable "instance_ami_id" {
  description = "The id of the AMI used for the autoscale instances"
  type        = string
  default     = null
}

variable "instance_timezone" {
  description = "The timezone for the autocale instances"
  type        = string
  default     = "Asia/Seoul"
}

variable "instance_locale" {
  description = "The locale for the autocale instances"
  type        = string
  default     = "en_US.UTF-8"
}

variable "instance_type" {
  description = "The autoscale instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_volume_size" {
  description = "The total size of the autoscale instance volume in gigabytes (root block size(=8GB) + EBS block size)"
  type        = number
  default     = 30
}

variable "instance_volume_type" {
  description = "The type of the autoscale instance volume"
  type        = string
  default     = "gp2"
}

variable "instance_security_group_ids" {
  description = "The list of security group ids to associate with autoscale instances"
  type        = list(string)
  default     = []
}

variable "instance_enable_monitoring" {
  description = "If true, autoscale instance will have detailed monitoring enabled"
  default     = false
}

variable "instance_user_data" {
  description = "The init script for EC2"
  default     = null
}

variable "iam_instance_profile" {
  description = "The instance profile. If not set, creates new one"
  default     = null
}

variable "iam_instance_role_policy_arns" {
  description = "The list of additional instance role policys attached to newly created profile (ignored if iam_instance_profile is set)"
  type        = list(string)
  default     = []
}

variable "metric_alarm_actions" {
  description = "The actions of CloudWatch metric alarm"
  type        = list(string)
  default     = []
}

variable "metric_alarm_memory_util_threshold" {
  description = "The threshold of memory utilization CloudWatch metric alarm"
  type        = number
  default     = 80
}

variable "metric_alarm_memory_util_period" {
  description = "The period of memory utilization CloudWatch metric alarm"
  type        = number
  default     = 60
}

variable "metric_alarm_cpu_util_threshold" {
  description = "The threshold of CPU utilization CloudWatch metric alarm"
  type        = number
  default     = 80
}

variable "metric_alarm_cpu_util_period" {
  description = "The period of CPU utilization CloudWatch metric alarm"
  type        = number
  default     = 60
}

variable "task_stopped_event_target_arn" {
  description = "The arn of task stopped event target"
  type        = string
  default     = null
}
