resource "aws_security_group" "worker_node_sg" {
  name        = "eks-worker-nodes"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # 🔒 SSH – restrict or remove
  ingress {
    description = "SSH from office IP / bastion only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ App traffic from NLB (HTTP)
  ingress {
    description = "NLB to worker nodes"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ✅ Node-to-node communication
  ingress {
    description = "Worker node to worker node"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  # ✅ Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
