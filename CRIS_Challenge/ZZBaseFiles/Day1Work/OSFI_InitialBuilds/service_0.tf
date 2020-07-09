resource "kubernetes_service" "service_0" {
  provider = "kubernetes.DataCenter_0"
  metadata {
    name = "${var.TFVAR_CONTAINER}"
    namespace = "${var.TFVAR_NAMESPACE}"
    labels = {
      OSFI-app = "${var.TFVAR_CONTAINER}"
    }
  }

  spec {
    selector = {
      OSFI-app = "${var.TFVAR_CONTAINER}"
    }
    port {
      port = "80" # ignored when type equals NodePort
      target_port = "${var.TFVAR_CONTAINER_EXPOSED_PORT}"
      name = "${var.TFVAR_CONTAINER}-${var.TFVAR_CONTAINER_EXPOSED_PORT}"
    }

    type = "NodePort"
  }

  # This Section is uncommented out via the .ps1 file when the -OKD switch is used
  ##okdreplace## provisioner "local-exec" {
  ##okdreplace##  command = "oc expose svc/${var.TFVAR_CONTAINER}"
  ##okdreplace## }
}


