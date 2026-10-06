# ==========================================

# Spot Interruption Rule

# ==========================================

resource "aws_cloudwatch_event_rule" "spot_interruption" {
name = "${var.cluster_name}-spot-interruption"

description = "Capture EC2 Spot interruption warnings"

event_pattern = jsonencode({
source = [
"aws.ec2"
]

```
"detail-type" = [
  "EC2 Spot Instance Interruption Warning"
]
```

})

tags = var.common_tags
}

# ==========================================

# Rebalance Recommendation Rule

# ==========================================

resource "aws_cloudwatch_event_rule" "rebalance" {
name = "${var.cluster_name}-rebalance-recommendation"

description = "Capture EC2 rebalance recommendations"

event_pattern = jsonencode({
source = [
"aws.ec2"
]

```
"detail-type" = [
  "EC2 Instance Rebalance Recommendation"
]
```

})

tags = var.common_tags
}

# ==========================================

# Scheduled Maintenance Rule

# ==========================================

resource "aws_cloudwatch_event_rule" "maintenance" {
name = "${var.cluster_name}-scheduled-maintenance"

description = "Capture scheduled maintenance events"

event_pattern = jsonencode({
source = [
"aws.health"
]

```
"detail-type" = [
  "AWS Health Event"
]
```

})

tags = var.common_tags
}

# ==========================================

# Instance State Change Rule

# ==========================================

resource "aws_cloudwatch_event_rule" "state_change" {
name = "${var.cluster_name}-instance-state-change"

description = "Capture EC2 instance state changes"

event_pattern = jsonencode({
source = [
"aws.ec2"
]

```
"detail-type" = [
  "EC2 Instance State-change Notification"
]
```

})

tags = var.common_tags
}

# ==========================================

# Event Targets

# ==========================================

resource "aws_cloudwatch_event_target" "spot_interruption" {
rule = aws_cloudwatch_event_rule.spot_interruption.name

arn = var.sqs_queue_arn
}

resource "aws_cloudwatch_event_target" "rebalance" {
rule = aws_cloudwatch_event_rule.rebalance.name

arn = var.sqs_queue_arn
}

resource "aws_cloudwatch_event_target" "maintenance" {
rule = aws_cloudwatch_event_rule.maintenance.name

arn = var.sqs_queue_arn
}

resource "aws_cloudwatch_event_target" "state_change" {
rule = aws_cloudwatch_event_rule.state_change.name

arn = var.sqs_queue_arn
}

# ==========================================

# Allow EventBridge To Send To SQS

# ==========================================

data "aws_iam_policy_document" "sqs" {
statement {
effect = "Allow"

```
principals {
  type = "Service"

  identifiers = [
    "events.amazonaws.com"
  ]
}

actions = [
  "sqs:SendMessage"
]

resources = [
  var.sqs_queue_arn
]
```

}
}

resource "aws_sqs_queue_policy" "this" {
queue_url = var.sqs_queue_url

policy = data.aws_iam_policy_document.sqs.json
}
