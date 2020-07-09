resource "kubernetes_deployment" "deployment_0" {
  provider = "kubernetes.DataCenter_0"
  metadata {
    name = "${var.TFVAR_CONTAINER}"
    namespace = "${var.TFVAR_NAMESPACE}"
    labels = {
      OSFI-app = "${var.TFVAR_CONTAINER}"
    }
  }

  spec {
    replicas = "${var.TFVAR_REPLICA_COUNT}"

    selector {
      match_labels = {
        OSFI-app = "${var.TFVAR_CONTAINER}"
      }
    }
    template {
      metadata {
        labels = {
          OSFI-app = "${var.TFVAR_CONTAINER}"
        }
      }
      spec {
        container {
          image = "${var.TFVAR_IMAGE_URL}"
          name  = "${var.TFVAR_CONTAINER}"
          
          port {
            container_port = "${var.TFVAR_CONTAINER_EXPOSED_PORT}"
          }
        }
      }
    }
  }
}
