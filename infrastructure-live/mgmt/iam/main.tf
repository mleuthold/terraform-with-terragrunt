provider "aws" {}

data "aws_iam_policy" "AdministratorAccess" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "iac_role" {
  name               = "mgmt-role"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::<AWS_ACCOUNT_ID>:role/ci_cd_role",
          "arn:aws:iam::<AWS_ACCOUNT_ID>:role/administrator_role"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "gitlab_runner_access_assume_role-admin_policy_attachment" {
  role       = aws_iam_role.iac_role.name
  policy_arn = data.aws_iam_policy.AdministratorAccess.arn
}

