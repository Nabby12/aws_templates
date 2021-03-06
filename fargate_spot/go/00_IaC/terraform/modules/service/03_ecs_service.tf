# ------------------------------------------------------------#
# ECS Service
# ------------------------------------------------------------#
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.env}-${var.pj_prefix}-ecs-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base              = 0
    weight            = 1
  }
  network_configuration {
    subnets = [
      "${var.subnet1}",
      "${var.subnet2}",
      "${var.subnet3}"
    ]
    security_groups = [
      "${var.container_sg_id}"
    ]
    assign_public_ip = false
  }

  depends_on = [
    aws_ecs_task_definition.task_definition
  ]
}
