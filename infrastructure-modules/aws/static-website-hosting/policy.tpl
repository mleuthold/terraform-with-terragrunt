{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "2",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${ORIGIN_ACCESS_IDENTITY_ARN}"
            },
            "Action": "s3:GetObject",
            "Resource": "${S3_BUCKET_ARN}/*"
        }
    ]
}
