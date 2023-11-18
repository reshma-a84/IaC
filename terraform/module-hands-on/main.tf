resource "random_string" "name" {
  length = 8
  special = false
  upper = false

}

locals {
  prefix = "random-${random_string.name.result}"
}


module "myModule" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "${local.prefix}-s3"
  # depends_on = [ module.mySNS ]
}


module "s3-bucket_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  bucket = module.myModule.s3_bucket_id
  sns_notifications = { }
   topic {
    topic_arn     = module.mySNS.topic.arn
    events        = ["s3:ObjectCreated:*"]
    # filter_suffix = ".log"
  }

}

output "s3_bucket_name" {
    value = module.myModule.s3_bucket_id
}


module "mySNS" {
  source = "terraform-aws-modules/sns/aws"
  # version = "~> 3.0"
  name = "${local.prefix}-sns-topic"
}

output "sns_topic_arn" {
  value = module.mySNS.topic_id
  
}
# module "notifications" {
#     source = "modules/notification/main.tf"
#     bucket = module.myModule.s3_bucket_id
#     sns_notifications ={
#     sns = {
#         topic_arn = module.sns.sns_topic_arn
#         events        = ["s3:ObjectCreated:Put"]
#     }
#   }

# }

