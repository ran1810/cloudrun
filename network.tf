resource "google_compute_network" "vpc" {
  name = "vpc-network"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.name
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  purpose       = "PRIVATE_NAT"
  network       = google_compute_network.vpc.name
}

resource "google_compute_global_address" "vpc_connector_ip" {
  name          = "vpc-connector-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.vpc_connector_ip.name]
}

resource "google_vpc_access_connector" "vpc_connector" {
  name          = "vpc-connector"
  region        = var.region
  ip_cidr_range = "10.8.1.0/28"
  network = google_compute_network.vpc.id
}
