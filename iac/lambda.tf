data "archive_file" "business_logic" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda/business_logic.zip"
}

data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_business" {
  name               = "safestock-lambda-business"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_business.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_xray" {
  role       = aws_iam_role.lambda_business.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_lambda_function" "business_logic" {
  function_name    = "safestock-business-logic"
  role             = aws_iam_role.lambda_business.arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.business_logic.output_path
  source_code_hash = data.archive_file.business_logic.output_base64sha256
  timeout          = 10

  reserved_concurrent_executions = 100

  tracing_config {
    mode = "Active"
  }
}
