# sns.tf
resource "aws_sns_topic" "sns_topic" {
  name = var.sns-topic
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  count = length(local.emails)
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint = local.emails[count.index]
}

# resource "aws_sns_topic_subscription" "sns_topic_subscription" {
#   for_each = toset(["emailid1@email.com","emailid2@email.com","emailid3@email.com"])
#   topic_arn = aws_sns_topic.sns_topic.arn
#   protocol  = "email"
#   endpoint = each.value
# }
