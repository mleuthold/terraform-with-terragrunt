variable "environment" {
  default = "dev"
}

variable "raw_data" {
  type = map(string)

  default = {
    schedule = ""
    path     = ""
  }
}

variable "master_data_parquet" {
  type = map(string)

  default = {
    schedule = ""
    path     = ""
  }
}

variable "master_data_json" {
  type = map(string)

  default = {
    schedule = ""
    path     = ""
  }
}

variable "crawler_configuration" {
  default = <<CONFIG
  {
    "Version":1.0,
    "CrawlerOutput":{
      "Partitions":{
        "AddOrUpdateBehavior":"InheritFromTable"
      },
      "Tables":{
        "AddOrUpdateBehavior":"MergeNewColumns"
      }
    },
    "Grouping":{
      "TableGroupingPolicy":"CombineCompatibleSchemas"
    }
  }
  CONFIG
}
