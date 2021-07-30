include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/dataset"
}

inputs = {
  name        = "data_quality"
  description = "This dataset contains items regarding Data Quality checking."
  location    = "US"
}
