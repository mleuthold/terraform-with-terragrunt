include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/external_table"
}

inputs = {
  dataset_name        = "dataset_raw"
  external_table_name = "customer_journey"
  source_uri          = "gs://dataset_raw/file_format=parquet/version_number=0.0.4/customer_journey/*"
}
