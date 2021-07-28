provider "google" {
  credentials = file(var.file_path_to_credentials)
  project     = var.project # "marketing-bi-219517"
  region      = var.region
  zone        = var.zone
}

terraform {
  backend "gcs" {}
}

resource "google_bigquery_table" "external_table" {
  dataset_id = var.dataset_name
  table_id   = var.external_table_name
  labels     = var.labels

  external_data_configuration {
    autodetect = true
    //    compression           = "GZIP"
    ignore_unknown_values = false
    max_bad_records       = 0
    source_format         = "PARQUET"
    source_uris = [
      var.source_uri,
    ]

    //    hive_partitioning_options {
    //      mode = "AUTO"
    //    }

    //    csv_options {
    //    }

    dynamic "hive_partitioning_options" {
      for_each = var.hive_partitioning_options
      content {
        mode              = var.hive_partitioning_options[0].mode
        source_uri_prefix = var.hive_partitioning_options[0].source_uri_prefix
      }
    }

    //    csv_options {
    //      quote                 = "\""
    //      encoding              = "UTF-8"
    //      allow_jagged_rows     = false
    //      allow_quoted_newlines = false
    //      field_delimiter       = ","
    //      skip_leading_rows     = 0
    //    }
  }
}
