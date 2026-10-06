terraform {
backend "s3" {
bucket         = "secure-platform-terraform-state"
key            = "dev/terraform.tfstate"
region         = "ap-south-1"
encrypt        = true
dynamodb_table = "secure-platform-terraform-locks"

```
# Recommended for production
versioning = true
```

}
}


/*

Now create these AWS resources manually once before running Terraform:

* S3 Backend Bucket

aws s3api create-bucket --bucket secure-platform-terraform-state \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1

* Enable versioning:

aws s3api put-bucket-versioning --bucket secure-platform-terraform-state \
  --versioning-configuration Status=Enabled

* Enable encryption:

aws s3api put-bucket-encryption --bucket secure-platform-terraform-state \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'
* DynamoDB Lock Table
aws dynamodb create-table --table-name secure-platform-terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region ap-south-1

*/