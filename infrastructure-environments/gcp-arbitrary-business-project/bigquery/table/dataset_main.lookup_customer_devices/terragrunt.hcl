include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/table"
}

inputs = {
  dataset_name = "dataset_main"
  table_name   = "lookup_customer_devices"
  description  = "Has lookup data to determine customers device."

  schema = jsonencode(
    [
      {
        mode = "NULLABLE"
        name = "customer"
        type = "STRING"
      },
      {
        mode = "NULLABLE"
        name = "device_id"
        type = "INTEGER"
      },

    ]
  )

}
