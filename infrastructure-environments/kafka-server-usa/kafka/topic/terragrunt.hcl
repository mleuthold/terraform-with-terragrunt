include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/kafka/topic"
}

inputs = {
  name              = "example-topic-dev"
  bootstrap_servers = "localhost:9091"
}
