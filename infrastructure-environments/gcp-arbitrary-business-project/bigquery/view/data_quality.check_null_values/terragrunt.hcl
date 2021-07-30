include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/view"
}

inputs = {
  dataset_name = "data_quality"
  view_name    = "check_null_values"
  query        = <<-EOT
  SELECT
    *
  FROM
    dataset_intermediate.etl_clean_dates
  EOT
}
