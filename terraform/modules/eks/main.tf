data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster" {
  name               = "eks_cluster"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "eks_policy" {
  statement {
    effect = "Allow"
    actions = [
      "eks:DescribeCluster",
      "eks:ListClusters",
      "eks:UpdateKubeconfig"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "eks_policy" {
  name   = "eks_policy"
  role   = aws_iam_role.eks_cluster.name
  policy = data.aws_iam_policy_document.eks_policy.json
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

  depends_on = [aws_iam_role_policy.eks_policy]
}
