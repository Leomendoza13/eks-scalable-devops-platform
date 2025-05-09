resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.monitoring_lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "<html><body><h1>Monitoring Services Portal</h1></body></html>"
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener_rule" "prometheus" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_http_tg.arn
  }

  condition {
    host_header {
      values = ["eksprometheus.duckdns.org"]
    }
  }
}

resource "aws_lb_listener_rule" "grafana" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_http_tg.arn
  }

  condition {
    host_header {
      values = ["eksgrafana.duckdns.org"]
    }
  }
}

resource "aws_lb_listener_rule" "alertmanager" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_http_tg.arn
  }

  condition {
    host_header {
      values = ["eksalertmanager.duckdns.org"]
    }
  }
}

resource "aws_lb_listener_rule" "jenkins" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 40

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_http_tg.arn
  }

  condition {
    host_header {
      values = ["eksjenkins.duckdns.org"]
    }
  }
}

resource "aws_lb_listener_rule" "argocd" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 50

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ingress_http_tg.arn
  }

  condition {
    host_header {
      values = ["eksargocd.duckdns.org"]
    }
  }
}