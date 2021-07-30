include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/table"
}

inputs = {
  dataset_name = "dataset_intermediate"
  table_name   = "etl_clean_dates"

  schema = jsonencode(
    [
      { name = "date"
        type = "STRING"
      mode = "NULLABLE" },
      { name = "date_as_int"
        type = "INTEGER"
      mode = "NULLABLE" },

      { name = "aggregation"
        type = "FLOAT"
      mode = "NULLABLE" },






    ]
  )

}
