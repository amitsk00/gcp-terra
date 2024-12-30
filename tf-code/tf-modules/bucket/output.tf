

output first_self_link {
    value = google_storage_bucket.first_bucket.self_link
}

output first_bucket_url {
    value = google_storage_bucket.first_bucket.url
}

output custom_self_link {
    value = google_storage_bucket.custom_bucket.self_link
}

output custom_url {
    value = google_storage_bucket.custom_bucket.url
}