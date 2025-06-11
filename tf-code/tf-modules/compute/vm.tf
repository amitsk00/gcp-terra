resource "google_compute_instance" "test1" {
	name         = var.vm_name 
	machine_type = var.mac_type_e2m
	zone         = var.zone 

	tags = ["foo", "bar"]

	boot_disk {
		initialize_params {
			image = var.vm_image
			labels = {
			my_label = "value"
			}
		}
	}

	# // Local SSD disk
	# scratch_disk {
	#   interface = "SCSI"
	# }

	network_interface {
	network = var.vpc_name
	subnetwork = var.subnet_name

	# access_config {
	#   // Ephemeral public IP
	# }
	}


	# dynamic "metadata_values" {
	# 	for_each = var.metadata_vm
	# 	content {
	# 		key = metadata_values.value.key
	# 		value = metadata_values.value.value
	# 	}
	# }


	metadata_startup_script = var.startup_url

	service_account {
		# Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
		email  = var.sa_vm_email
		scopes = ["cloud-platform"]
	}
}

