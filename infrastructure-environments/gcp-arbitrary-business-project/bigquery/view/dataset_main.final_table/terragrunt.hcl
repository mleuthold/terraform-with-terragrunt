include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/view"
}

inputs = {
  dataset_name = "dataset_main"
  view_name    = "final_table"
  query        = <<-EOT
  SELECT
    *
  FROM
    dataset_main.lookup_customer_devices
  EOT
}
