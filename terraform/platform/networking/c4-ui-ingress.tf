# ------------------------------------------------------------------------------
# UI Ingress
#
# Creates an Internet-facing AWS Application Load Balancer
# and exposes the Retail Store UI.
#
# ExternalDNS automatically creates:
#
#   shop.tinacloud.dev
#
# ------------------------------------------------------------------------------

resource "kubernetes_ingress_v1" "ui" {

  metadata {

    name = "ui"

    namespace = "default"

    annotations = {

      "kubernetes.io/ingress.class" = "alb"

      "alb.ingress.kubernetes.io/scheme" = "internet-facing"

      "alb.ingress.kubernetes.io/target-type" = "ip"

      "alb.ingress.kubernetes.io/listen-ports" = "[{\"HTTP\":80},{\"HTTPS\":443}]"

      "alb.ingress.kubernetes.io/certificate-arn" = "arn:aws:acm:us-east-1:162663626265:certificate/a4eb55e2-32e6-4241-8775-262a19640c13"

      "alb.ingress.kubernetes.io/ssl-redirect" = "443"

      "alb.ingress.kubernetes.io/healthcheck-path" = "/"

      "alb.ingress.kubernetes.io/success-codes" = "200"

      "external-dns.alpha.kubernetes.io/hostname" = "shop.tinacloud.dev"

    }

  }

  spec {

    ingress_class_name = "alb"

    rule {

      host = "shop.tinacloud.dev"

      http {

        path {

          path = "/"

          path_type = "Prefix"

          backend {

            service {

              name = "ui"

              port {

                number = 80

              }

            }

          }

        }

      }

    }

  }

  depends_on = [

    helm_release.external_dns

  ]

}

# ------------------------------------------------------------------------------
# Outputs
# ------------------------------------------------------------------------------

output "ui_hostname" {

  value = "shop.tinacloud.dev"

}