resource "aws_lambda_function" "lambda-function" {
  function_name    = "${var.tags}-lamda-function"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "python3.9"
  filename         = "lambda_function.py"
  source_code_hash = filebase64sha256("lambda_function.zip")
  handler          = "index.test"
  vpc_config {
    subnet_ids = aws_db_subnet_group.capstone_db.subnet_ids
  }

  depends_on = [
    aws_iam_role.lambda_role
  ]
  tags = {
    "Name" = "${var.tags}-lambda-function"
  }
}