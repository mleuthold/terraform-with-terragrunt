include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../infrastructure-modules/gcp/bigquery/dataset"
}

inputs = {
  name        = "dataset_main"
  description = "This dataset contains items regarding final tables for data consumers in location US."
  location    = "US"
}
