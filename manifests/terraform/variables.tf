variable "region" {
  description = "阿里云地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "project" {
  description = "项目名（资源命名前缀）"
  type        = string
  default     = "qtstrategy"
}

variable "environment" {
  description = "环境：dev / prod"
  type        = string
  default     = "prod"
}

# ============================================================
# site（React+Vite 官网，.github/workflows/deploy-site.yml）相关变量
# ============================================================
variable "oss_bucket_name" {
  description = "站点桶名（OSS 全局唯一；静态网站模式）"
  type        = string
  default     = "qtstrategy-site"
}
