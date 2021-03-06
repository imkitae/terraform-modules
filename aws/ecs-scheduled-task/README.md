# ecs-scheduled-task

## Usage
```hcl
module "scheduled_task" {
  source = "github.com/ridi/terraform-modules//aws/ecs-scheduled-task"
  
  name = "my-service"
  
  cluster_arn         = "my-cluster"
  event_role_arn = ""
  schedule_expression = "cron(30 19 * * ? *)"

  # If you runs with EC2 type instead Fargate, ignore belows (launch_type, awsvpc_*).
  launch_type            = "FARGATE"
  awsvpc_subnet_ids      = data.aws_subnet_ids.private.ids
  awsvpc_security_groups = ["sg-1234abcd"]
  
  container_definitions = [
    {
      name  = "app",
      image = "my-repo/my-image:1.0",
      portMappings = [
        { containerPort = 80 }
      ],
      environment = [
        { name = "FOO", value = "This is FOO" },
        { name = "BAR", value = "This is BAR" },
      ],
      secrets = [
        { name = "DB_HOST", valueFrom = "/rds/host" },
        { name = "DB_DBNAME", valueFrom = "/rds/db/my-service" },
        { name = "DB_USER", valueFrom = "/rds/user/someone/username" },
        { name = "DB_PASSWORD", valueFrom = "/rds/user/someone/password" },
      ],
      essential         = true
      cpu               = 100,
      memory            = 200,
      memoryReservation = 100,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-region        = "ap-northeast-2",
          awslogs-group         = "/ecs/my-cluster/my-service"
          awslogs-stream-prefix = "1.0"
        }
      },
    },
  ]
    
  task_num = 1
}
```

## Input Variables

### CloudWatch Event Rule
- `name` - The name of the scheduling event rule and task definition (if new task is created)
- `description` - The description of the scheduling event rule
- `schedule_expression` - The scheduling expression. For example, "cron(0 20 * * ? *)" or "rate(5 minutes)".
- `is_enabled` - Whether the rule should be enabled

### CloudWatch Event Target
- `cluster_arn` - The ARN of ECS cluster to deploy this ECS service on
- `launch_type` - The launch type on which to run your service. ('EC2' or 'FARGATE')
- `iam_event_role_arn` - The ARN of IAM role that is used for event target invocation
- `awsvpc_subnet_ids` - The subnets associated with the task or service (task_network_mode)
- `awsvpc_security_groups` - The security groups associated with the task or service
- `awsvpc_assign_public_ip` - Whether assigns a public IP address to the ENI or not
- `task_definition_arn` - The arn of task definition. If not set, creates new one. (requires `container_definitions`)
- `task_num` - The number of tasks to be deployed
- `container_overrides` - The definition override of containers. `[{ name = 'name-of-container-to-override', 'key-to-override' = 'value', ... }, {...}]`

### ECS Task Definition
These variables are ignored if `task_definition_arn` is set
- `task_cpu` - The number of cpu units used by the task. (used in Fargate)
- `task_memory` - The amount (in MB) of memory used by the task. (used in Fargate)
- `task_network_mode` - The Docker networking mode to use for the containers in the task. ('none', 'bridge', 'awsvpc', 'host')
- `iam_task_role_arn` - The ARN of IAM role of ECS task
- `iam_exec_role_arn` - ARN of IAM role to execute ECS task
- `container_definitions` - The definitions of each container. (See https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/create-task-definition.html)
