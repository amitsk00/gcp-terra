resource "google_bigquery_dataset" "bqdataset" {
  project                     = var.project_id
  dataset_id                  = "activities"
  friendly_name               = "activities"
  description                 = "Pluto Table(s)"
  location                    = "US"
}

resource "google_bigquery_table" "bqtable" {
  project             = var.project_id
  depends_on          = [google_bigquery_dataset.bqdataset]
  dataset_id          = google_bigquery_dataset.bqdataset.dataset_id
  table_id            = "resources"
  schema              = <<EOF
    [
        {"name": "messages","type": "STRING"}
    ]
    EOF
  deletion_protection = false
}




