# ------------------------------------------------------------------------------
# IAM Policy for the Catalog microservice
#
# Grants read-only access to the MySQL credentials stored in
# AWS Secrets Manager.
# ------------------------------------------------------------------------------

resource "aws_iam_policy" "catalog_secretsmanager_policy" {

  name = "${var.environment}-catalog-secretsmanager-policy"

  description = "Allows the Catalog microservice to retrieve MySQL credentials from AWS Secrets Manager."

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"

        ]

        Resource = aws_db_instance.catalog_mysql.master_user_secret[0].secret_arn

      }

    ]

  })

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-catalog-secretsmanager-policy"
    }
  )

}