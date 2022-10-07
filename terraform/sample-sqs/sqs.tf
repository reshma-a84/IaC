resource "aws_sqs_queue" "tf-queue" {
    name = var.sqs-name
    delay_seconds = var.delay_seconds
}