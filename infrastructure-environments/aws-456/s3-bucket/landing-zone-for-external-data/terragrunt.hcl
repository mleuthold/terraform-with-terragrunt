include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../..//infrastructure-modules/aws/s3-bucket"
}

inputs = {
  bucket_name = "landing-zone-for-external-data"
}
