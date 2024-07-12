resource "google_cloud_run_service" "default" {
  name     = "cloud-run-service"
  location = var.region

  template {
    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
        env {
          name  = "DB_INSTANCE_CONNECTION_NAME"
          value = google_sql_database_instance.postgres.connection_name
        }
        env {
          name  = "DB_USER"
          value = "postgres"
        }
        env {
          name  = "DB_PASS"
          value = var.db_password
        }
      }

    }
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.vpc_connector.name
      }

    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_project_service.run,
  ]
}

resource "google_project_service" "run" {
  service = "run.googleapis.com"
  depends_on = [
    google_project_service.sqladmin,
  ]
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}
