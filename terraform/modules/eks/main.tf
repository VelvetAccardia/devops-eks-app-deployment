resource "aws_iam_role" "eks_cluster" {
  name               = "eks_cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}




resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_eks_cluster" "eks_devops_cluster" {
  name     = "eks_devops_cluster"
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.27"

  vpc_config {
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    subnet_ids = [
      var.pub_subnet_id_1,
      var.pub_subnet_id_2,
      var.pvt_subnet_id_1,
      var.pvt_subnet_id_2
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

