# =============================================================================
# Site CDN + DNS（strategy.quanttide.com）
#
# 链路：OSS 静态网站桶（site-bucket.tf，私有）→ CDN 加速 + 私有回源鉴权
#   → CNAME 接入（云解析）→ 用户浏览器
#
# 说明（对齐 qtcrowd cdn.tf 惯例）：
#   - 桶 ACL 私有，回源鉴权分两步：
#     ① 账号级授权（本文件 RAM 角色/策略，对齐阿里云官方文档命名）
#     ② 域名级开关：l2_oss_key private_oss_auth=on（本文件配置）
#   - SSL 证书：复用泛域名证书 *.quanttide.com，由 scripts/configure-site-cdn.sh
#     绑定（续期后重跑）；未绑定前域名仅 HTTP 可用
#   - SPA 回退：React Router（BrowserRouter）子路由（/strategies）刷新 404
#     → back_to_origin_url_rewrite 统一改写为 /index.html
#   - 前置：quanttide.com 已完成 ICP 备案
# =============================================================================

resource "alicloud_cdn_domain_new" "site" {
  domain_name = "strategy.quanttide.com"
  cdn_type    = "web"

  # 源站：OSS 静态网站桶（site 专用桶 qtstrategy-site——上传目标一致）
  sources {
    content  = "qtstrategy-site.oss-cn-hangzhou.aliyuncs.com"
    type     = "oss"
    port     = 80
    priority = 20
  }
}

# ── 私有 Bucket 回源开关（l2_oss_key：private_oss_auth=on，自动 STS 同账号回源） ──
# 说明：oss_auth 函数（FunctionID 10）由平台在配置 OSS 源站时自动添加，勿手动配置；
# 此处仅开启私有回源开关。与 OSS 静态网站托管默认首页存在已知冲突，若回源 403
# 按官方文档处理（https://www.alibabacloud.com/help/zh/cdn/user-guide/grant-alibaba-cloud-cdn-access-permissions-on-private-oss-buckets）
resource "alicloud_cdn_domain_config" "site_private_back" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "l2_oss_key"
  function_args {
    arg_name  = "private_oss_auth"
    arg_value = "on"
  }
}

# SPA 回退改写：React Router（BrowserRouter）直接访问/刷新子路由（如 /strategies）
# 时回源 OSS 会 404，统一改写为 /index.html；真实产物（index.html、assets/、vite.svg）保持原样回源。
resource "alicloud_cdn_domain_config" "site_spa_fallback" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "back_to_origin_url_rewrite"
  function_args {
    arg_name  = "source_url"
    arg_value = "^/(?!index\\.html$|assets/|vite\\.svg$).*"
  }
  function_args {
    arg_name  = "target_url"
    arg_value = "/index.html"
  }
  function_args {
    arg_name  = "flag"
    arg_value = "break"
  }
}

# 强制 HTTPS：HTTP 请求 301 跳转 HTTPS（证书绑定后启用）
resource "alicloud_cdn_domain_config" "site_https_force" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "https_force"
  function_args {
    arg_name  = "enable"
    arg_value = "on"
  }
}

# ── 账号级授权说明 ─────────────────────────────────────────
# CDN 回源私有 OSS 的账号级角色（AliyunCDNAccessingPrivateOSSRole / ...Policy）
# 由 qtcrowd 首次创建、平台 modules/cdn-auth 收敛管理，本仓库不重复创建
# （各仓库独立 tfstate，重复 apply 会撞 EntityAlreadyExists），仅依赖其存在。

# ── DNS：CNAME 接入 ─────────────────────────────────────────

resource "alicloud_alidns_record" "site" {
  domain_name = "quanttide.com"
  rr          = "strategy"
  type        = "CNAME"
  value       = alicloud_cdn_domain_new.site.cname
  ttl         = 600
}
