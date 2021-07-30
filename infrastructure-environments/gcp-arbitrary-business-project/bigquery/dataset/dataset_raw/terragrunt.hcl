include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/dataset"
}

inputs = {
  name        = "dataset_raw"
  description = "This dataset contains items regarding raw data from third parties in location EU."
  location    = "EU"
}
