resource "optumstorage_objectstoragebucket" "storage_s3bucket_0" {
  bucket_name   = ""   
  account_id    = ""   
}

output "storage_s3bucket_0_id" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.id}"
}

output "storage_s3bucket_0_account_id" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.account_id}"
}

output "storage_s3bucket_0_storage_location" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.storage_location}"
}
output "storage_s3bucket_0_creation_time" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.creation_time}"
}

output "storage_s3bucket_0_object_count" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.object_count}"
}

output "storage_s3bucket_0_bytes_used" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.bytes_used}"
}

output "storage_s3bucket_0_total_used" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.total_used}"
}

output "storage_s3bucket_0_endpoint_internal_zone" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.endpoint_internal_zone}"
}

output "storage_s3bucket_0_endpoint_dmz_zone" {
  value = "${optumstorage_objectstoragebucket.storage_s3bucket_0.endpoint_dmz_zone}"
}