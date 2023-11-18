resource "random_string" "hands_on_random_string" {
  special = false
  upper   = false
  length  = 4
}

locals {
  prefix = random_string.hands_on_random_string.result
}