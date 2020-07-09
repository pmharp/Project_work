resource "kubernetes_network_policy" "networkpolicy_0" {
    provider = "kubernetes.DataCenter_0"
    metadata {
        name      = "${var.TFVAR_CONTAINER}"
        namespace = "${var.TFVAR_NAMESPACE}"
        labels = {
                OSFI-app = "${var.TFVAR_CONTAINER}"
            }
    }

    spec {
        pod_selector {
            match_labels = {
                OSFI-app = "${var.TFVAR_CONTAINER}"
            }
        }

        policy_types = ["Ingress", "Egress"]

        ingress {
            ports {
                port     = "${var.TFVAR_CONTAINER_EXPOSED_PORT}"
                protocol = "TCP"
            }
        }
      

        egress {
        } 
    }
}
