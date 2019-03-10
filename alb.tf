locals {
  name       = "${var.project}-alb"
  ssl_policy = "ELBSecurityPolicy-2016-08"
}

#################################################
# Load Balancer
#################################################
resource "aws_lb" "lb" {
  name                       = "${local.name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = "${var.security_group_ids}"
  subnets                    = "${var.subnet_ids}"
  enable_deletion_protection = false

  tags = {
    Name = "${local.name}"
  }
}

#################################################
# Listener
#################################################
resource "aws_lb_listener" "redirect" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.lb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "${local.ssl_policy}"
  certificate_arn   = "${var.acm_arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb.arn}"
  }
}
