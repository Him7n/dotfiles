terraform {
  required_providers {
    harness = {
      source = "harness/harness"
    }
  }
}

provider "harness" {
  endpoint         = "https://gitopsautomation.pr2.harness.io/"
  account_id       = "0UG6mpX9S3ajRIJ6Ldg-IQ"
  platform_api_key = "pat.0UG6mpX9S3ajRIJ6Ldg-IQ.688915aa33a71c56bb3f33c6.J5B8jFHES9OaoI4F0n56"
}

locals {
  account_id       = "0UG6mpX9S3ajRIJ6Ldg-IQ"
  org_id           = "default"
  project_id       = "GitOpsFilterTest_YdEboR2xyU"
  agent_id         = "test2"
  scoped_agent_id  = "test2"
}

resource "harness_platform_gitops_cluster" "cluster11" {
  identifier     = "cluster-11"
  account_id     = local.account_id
  project_id     = local.project_id
  org_id         = local.org_id
  agent_id       = local.scoped_agent_id
  force_delete   = true
  force_update   = false

  request {
    upsert = true
    cluster {
      server = "https://35.233.139.33"
      name   = "cluster11_new"
      config {
        bearer_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjB0OFBkZ2Z2OWtiR0owbXFBMXBINjJZYnpkQV9PZE5Xb1NrN01CT1NXVnMifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImdpdG9wcy10b2tlbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJnaXRvcHMtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJjNmU2ZDRkYi0wM2Y0LTRlZTQtYmU4Mi03MDk3ZmJiYzY2ZGIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpnaXRvcHMtc2EifQ.sYBmwLhV0lTG9pF6m2ukD8k1igcrgNykt_Zqir6KNDfMZnhw_joUMIRaR6U7IW5BUyGTBAJgbNucSOd-rRMXSL1C5XKKptPOaf75qCvheyvhBeZo6NaF_lhZYtlua6mMn3cI-GfqMShCYIoQvjdxAxZBL-mExVSFKx2Qh4uONrs9hqj2nHAj1bKJ0s3XA66PSnH21i9R9HipTdE5pXA84ZA2B2OUOK-VfTvb0MjmXW-r9rrerQ0JWlZPV9WQ_QxYwZFkPfPGkDjtPWwYm9wAK_NtzB3GEa_0wsY6jWdqkPOjOMY1yTOzetWmO5-WFksDFoAzVk3NMKp9d1hjkdj8GQ"
        tls_client_config {
          insecure = true
          ca_data  = ""
        }
        cluster_connection_type = "SERVICE_ACCOUNT"
      }
    }
  }
}

resource "harness_platform_gitops_applications" "testtf" {
  depends_on = [harness_platform_gitops_cluster.cluster11] # 👈 Ensures the cluster is created first

  application {
    metadata {
      annotations = {}
      labels      = {}
      name        = "testtf"
    }
    spec {
      sync_policy {
        sync_options = [
          "PrunePropagationPolicy=undefined",
          "CreateNamespace=false",
          "Validate=false",
          "skipSchemaValidations=false",
          "autoCreateNamespace=false",
          "pruneLast=false",
          "applyOutofSyncOnly=false",
          "Replace=false",
          "retry=false"
        ]
      }
      source {
        target_revision = "main"
        repo_url        = "https://github.com/Him7n/k8_s"
        path            = "k8_s_test/"
      }
      destination {
        name      = "cluster11"
        namespace = "himanshu-test"
      }
    }
  }

  account_id = local.account_id
  org_id     = local.org_id
  project_id = local.project_id

  identifier = "testtf"
  name       = "testtf"

  cluster_id = harness_platform_gitops_cluster.cluster11.identifier
  repo_id    = "himanrepo"
  agent_id   = local.agent_id
}
