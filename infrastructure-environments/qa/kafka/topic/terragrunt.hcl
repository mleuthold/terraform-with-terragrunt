include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/kafka/topic"
}

inputs = {
  name              = "example-topic-stg"
  bootstrap_servers = "localhost:9091"
}
