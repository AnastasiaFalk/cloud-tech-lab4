variable "lambda_arn" { type = string }

resource "aws_cloudwatch_event_rule" "every_hour" {
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.every_hour.name
  target_id = "lambda"
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "events.amazonaws.com"
}