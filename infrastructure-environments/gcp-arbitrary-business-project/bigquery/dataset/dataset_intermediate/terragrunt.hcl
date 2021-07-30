include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/dataset"
}

inputs = {
  name        = "dataset_intermediate"
  description = "This dataset contains items regarding intermediate ETL tables in location US."
  location    = "US"
}
