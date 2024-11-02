# create IAM role - assigning the role amozon ec2 trust capabilties to access tokens and secret ids
resource "aws_iam_role" "ec2_role" {
  name = "achia_role"
  
    # setring up json policy
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

# setting up s3 policy
resource "aws_iam_policy" "s3_access_policy" {
  name = "achia_s3_access_policy"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket"
        ],
        "Resource": "arn:aws:s3:::achia-bucket"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": "arn:aws:s3:::achia-bucket/*"
      }
    ]
  })
}

# Attach the custom S3 policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_s3_access_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}


resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "achia_instance_profile"
  role = aws_iam_role.ec2_role.name
}
