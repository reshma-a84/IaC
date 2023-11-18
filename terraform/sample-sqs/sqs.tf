resource "aws_sqs_queue" "tf-queue" {
    name = var.sqs-name
    delay_seconds = var.delay_seconds
}

output "queue_url" {
  value = aws_sqs_queue.tf-queue.url
}