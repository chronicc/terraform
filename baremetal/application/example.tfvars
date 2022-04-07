kubectl_context = ""

basic_example_host = ""
cert_example_host  = ""


## Gitlab Runner
##
gitlab_runner_gitlab_url           = "https://gitlab.com/"
gitlab_runner_helm_chart           = "gitlab-runner"
gitlab_runner_helm_repository      = "https://charts.gitlab.io"
gitlab_runner_helm_version         = "0.39.0"
gitlab_runner_token                = "t0k3n"
gitlab_runner_s3_cache_access_key  = "s3cr3t"
gitlab_runner_s3_cache_address     = "minio.local"
gitlab_runner_s3_cache_bucket_name = "gitlab-runner"
gitlab_runner_s3_cache_enabled     = false
gitlab_runner_s3_cache_region      = "eu-central-1"
gitlab_runner_s3_cache_secret_key  = "s3cr3t"

## Minio
##
minio_helm_chart      = "minio"
minio_helm_repository = "https://charts.bitnami.com/bitnami"
minio_helm_version    = "11.2.6"
minio_ingress_host    = "minio.local"
minio_root_password   = "s3cr3t"
minio_storage_size    = "10Gi"
minio_storage_volume  = ""