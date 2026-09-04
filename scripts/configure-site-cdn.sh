#!/bin/bash
# 为 strategy.quanttide.com（战略中心 site 官网）绑定 CDN HTTPS 证书。
#
# 背景：strategy.quanttide.com 是量潮战略中心发布域名，CDN 源站为 OSS 桶 qtstrategy-site
# （基础设施见 manifests/terraform/cdn.tf，由 deploy-site.yml 自动应用；DNS CNAME 同步创建）。
# 证书为 acme.sh 签发的泛域名证书 *.quanttide.com（ZeroSSL），续期后需重跑本脚本更新证书。
#
# 前置：本机已登录 aliyun CLI（AK 模式）；acme.sh 证书目录存在。
# 说明：DNS CNAME 与 CDN 域名由 terraform 管理，本脚本只负责证书绑定（terraform 不管理证书内容）。
set -e

DOMAIN='strategy.quanttide.com'
CERT_DIR='/home/iguo/.acme.sh/*.quanttide.com_ecc'
CERT_NAME="cert-${DOMAIN}-$(date +%s)"

echo "=== 绑定 HTTPS 证书（CDN）==="
aliyun cdn SetCdnDomainSSLCertificate \
  --DomainName "$DOMAIN" \
  --CertName "$CERT_NAME" \
  --CertType upload \
  --SSLProtocol on \
  --SSLPub "$(cat "$CERT_DIR/fullchain.cer")" \
  --SSLPri "$(cat "$CERT_DIR/*.quanttide.com.key")"
