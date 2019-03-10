#################################################
# Target Group
#################################################
resource "aws_lb_target_group" "lb" {
  name     = "${var.project}-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}
