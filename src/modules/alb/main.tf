resource "aws_lb" "this" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnet_ids

  idle_timeout               = var.idle_timeout
  enable_deletion_protection = var.deletion_protection

  tags = merge(var.tags, {
    Name = var.load_balancer_name
  })
}

resource "aws_security_group" "this" {
  name        = "${var.load_balancer_name}-sg"
  description = "Allow HTTPS traffic to the application load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP for redirecting to HTTPS"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.load_balancer_name}-sg"
  })
}

# resource "aws_lb_target_group" "this" {
#   name        = var.target_group_name
#   port        = var.target_port
#   protocol    = var.target_protocol
#   vpc_id      = var.vpc_id
#   target_type = "ip"

#   health_check {
#     enabled             = true
#     healthy_threshold   = var.health_check_healthy_threshold
#     interval            = var.health_check_interval
#     matcher             = "200"
#     path                = var.health_check_path
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     timeout             = var.health_check_timeout
#     unhealthy_threshold = var.health_check_unhealthy_threshold
#   }

#   tags = merge(var.tags, {
#     Name = var.target_group_name
#   })
# }

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  # Define a dummy default action (Kubernetes will inject its own rules over this)
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404 Not Found"
      status_code  = "404"
    }
  }

  # CRITICAL: Tell Terraform to NEVER touch or reset the rules added by Kubernetes
  lifecycle {
    ignore_changes = [
      default_action,
    ]
  }
}

# resource "aws_lb_listener" "https" {
#   count = var.certificate_arn == null ? 0 : 1

#   load_balancer_arn = aws_lb.this.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = var.ssl_policy
#   certificate_arn   = var.certificate_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this.arn
#   }
# }
