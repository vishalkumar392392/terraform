resource "aws_security_group" "worker_node_sg" {
  name        = "eks-test"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # SSH (optional – restrict later)
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # NodePort range (REQUIRED for LoadBalancer services)
  ingress {
    description = "NodePort services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # (Optional but recommended) allow intra-node communication
  ingress {
    description = "Worker node to worker node"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
