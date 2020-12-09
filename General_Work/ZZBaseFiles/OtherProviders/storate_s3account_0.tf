resource "optumstorage_objectstorageaccount" "storage_s3account_0" {
  active_directory_group = ""  
  ask_id                 = ""   
  description            = ""  
}

output "storage_s3account_0_id" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.id}"
}

output "storage_s3account_0_account_id" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.account_id}"
}

output "storage_s3account_0_service_owner" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.service_owner}"
}

output "storage_s3account_0_access" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.access}"
}

output "storage_s3account_0_secret" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.secret}"
}

output "storage_s3account_0_bucket_count" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.bucket_count}"
}

output "storage_s3account_0_object_count" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.object_count}"
}

output "storage_s3account_0_bytes_used" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.bytes_used}"
}

output "storage_s3account_0_total_used" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.total_used}"
}

output "storage_s3account_0_endpoint_internal_zone" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.endpoint_internal_zone}"
}

output "storage_s3account_0_endpoint_dmz_zone" {
  value = "${optumstorage_objectstorageaccount.storage_s3account_0.endpoint_dmz_zone}"
}