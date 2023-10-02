

locals {
    sa_for_vm  = one([ for item in var.sa_list : item if can(regex("vm", item)) ])
}


data "google_compute_image" "my_image" {
    family  = "debian-11"
    project = "debian-cloud"
}

resource "google_compute_disk" "foobar" {
    name  = "existing-disk"
    image = data.google_compute_image.my_image.self_link
    size  = 100
    type  = "pd-ssd"
    zone  =  var.zone
}


resource "google_compute_instance_template" "lb-mig-tmpl" {
    name        = "vm-tmpl-lb1"
    description = "This template is used to create MIG as backend for LB."

    tags = ["foo", "bar"]

    labels = {
      environment = "dev"
      foo = "bar" 
    }

    metadata = {
      foo = "bar"
    }

    instance_description = "LB related "
    machine_type         = var.mac_type_f1m
    can_ip_forward       = false


    // Create a new boot disk from an image
    disk {
        # source_image      = "debian-cloud/debian-11"
        source_image = data.google_compute_image.my_image.self_link
        auto_delete       = true
        boot              = true
        // backup the disk every day
        # resource_policies = [google_compute_resource_policy.daily_backup.id]
    }

    # // Use an existing disk resource
    # disk {
    #     // Instance Templates reference disks by name, not self link
    #     source      = google_compute_disk.foobar.name
    #     auto_delete = false
    #     boot        = false
    # }

    network_interface {
        subnetwork = var.subnet_name
    }

    service_account {
        # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
        # email  = var.sa_mail
        email = local.sa_for_vm
        scopes = ["cloud-platform"]
    }

    scheduling {
        preemptible       = "${var.preemptible}"
        automatic_restart = "${var.automatic_restart}"
        on_host_maintenance = "MIGRATE"
    }      
}









resource "google_compute_health_check" "autohealing_mig" {
    name                = "autohealing-health-check-mig"
    check_interval_sec  = 5
    timeout_sec         = 5
    healthy_threshold   = 2
    unhealthy_threshold = 10 # 50 seconds

    http_health_check {
        request_path = "/"
        port         = "8080"
    }
}


resource "google_compute_instance_group_manager" "appserver_zonal" {
    provider = google-beta
    name = "mig-appserver"

    base_instance_name = "app-zonal"
    zone               = var.zone
    version {
        instance_template  = google_compute_instance_template.lb-mig-tmpl.self_link
    }

    all_instances_config {
        metadata = {
            foo_mig = "bar_mig-zonal"
        }
        labels = {
            "where" = "inside-mig"
            "scope" = "zonal"
        }
    }

    # target_pools = [google_compute_target_pool.appserver.id]
    target_size  = 2

    named_port {
      name = "customhttp"
      port = 8888
    }

    auto_healing_policies {
      health_check      = google_compute_health_check.autohealing_mig.id
      initial_delay_sec = 300
    }

    update_policy {
      type                           = "PROACTIVE"
      minimal_action                 = "REPLACE"
      most_disruptive_allowed_action = "REPLACE"
      max_surge_fixed                = 0
      max_unavailable_fixed          = 1
      min_ready_sec                  = 50
      replacement_method             = "RECREATE"
    }

    instance_lifecycle_policy {
        force_update_on_repair = "YES"
    }
}


output "zone_list" {
    value = "${local.distribution_zones["default"][0]}"
} 



resource "google_compute_region_instance_group_manager" "appserver_regional" {
    provider = google-beta
    name = "appserver-igm"

    base_instance_name         = "app-regional"
    region                     = var.region
    distribution_policy_zones  = "${local.distribution_zones["default"][0]}"

    version {
        instance_template = google_compute_instance_template.lb-mig-tmpl.self_link
    }

      all_instances_config {
          metadata = {
              foo_mig = "bar_mig-regional"
          }
          labels = {
              "where" = "inside-mig"
              "scope" = "regional"
          }
      }

    # target_pools = [google_compute_target_pool.appserver.id]
    target_size  = 2

    named_port {
        name = "custom"
        port = 8888
    }

    auto_healing_policies {
        health_check      = google_compute_health_check.autohealing_mig.id
        initial_delay_sec = 300
    }
    update_policy {
        type                           = "PROACTIVE"
        instance_redistribution_type   = "PROACTIVE"
        minimal_action                 = "REPLACE"
        most_disruptive_allowed_action = "REPLACE"
        max_surge_percent              = 0
        max_unavailable_fixed          = 0
        min_ready_sec                  = 50
        replacement_method             = "RECREATE"
    }

    instance_lifecycle_policy {
        force_update_on_repair = "YES"
    }
}



# Autoscalar config, for zonal and regional both

data "google_compute_zones" "available" {
    project = "${var.project_id}"
    region  = "${var.region}"
}

locals {
    distribution_zones = {
        default = ["${data.google_compute_zones.available.names}"]
        user    = ["${var.distribution_policy_zones}"]
    }


    zonal_mig = google_compute_instance_group_manager.appserver_zonal.name
    regional_mig = google_compute_region_instance_group_manager.appserver_regional.name

}




resource "google_compute_autoscaler" "scalar_zonal" {
    provider = google-beta
    count   = "${var.module_enabled && var.autoscaling ? 1 : 0}"
    #   name    = "${lcoal.zonal_mig}"
    name    = "${local.zonal_mig}"   
    zone    = "${var.zone}"
    project = "${var.project_id}"
    target  = "${local.zonal_mig}"   
        

    autoscaling_policy  {
        max_replicas               = "${var.max_replicas}"
        min_replicas               = "${var.min_replicas}"
        cooldown_period            = "${var.cooldown_period}"
        cpu_utilization {
            target = var.autoscaling_cpu 
        }

        # metric                     = ["${var.autoscaling_metric}"]
        # load_balancing_utilization = ["${var.autoscaling_lb}"]
    }
}


resource "google_compute_region_autoscaler" "scalar_regional" {
    provider = google-beta
    count   = "${var.module_enabled && var.autoscaling  ? 1 : 0}"
    name    = "${local.regional_mig}"
    region  = "${var.region}"
    project = "${var.project_id}"
    target  = "${local.regional_mig}"


    autoscaling_policy  {
        max_replicas               = "${var.max_replicas}"
        min_replicas               = "${var.min_replicas}"
        cooldown_period            = "${var.cooldown_period}"
        cpu_utilization {
            target = var.autoscaling_cpu 
        }

        # metric                     = ["${var.autoscaling_metric}"]
        # load_balancing_utilization = ["${var.autoscaling_lb}"]
    }
}

