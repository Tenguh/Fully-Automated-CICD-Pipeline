variable "name" {
  type        = string
  description = "name tag value"
}

variable "tags" {
  type        = map(any)
  description = "tags for the vpc module"
}

resource "aws_iam_role" "iam_role" {
  name = "${var.name}-iam-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags
}
resource "aws_iam_role_policy" "test_policy"{
  name ="${var.name}-iam-policy"
  role = aws_iam_role.iam_role.id

# Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.

  policy = jsonencode({
    Version = "2021-10-17"
    Statement =[
     {
      Action = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:PutlogEvents"
     ]
     Effect = "Allow"
     Resource ="*"
    },
  ]
})
}


