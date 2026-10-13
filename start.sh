#!/usr/bin/env bash
set -e

# 1. 获取动态端口（适应 Railway 等平台，默认 8080）
PORT="${PORT:-8080}"
echo "[INFO] 当前平台分配运行端口: ${PORT}"

# 2. 动态渲染 Nginx 配置文件
export PORT
if [ -f /app/nginx.conf.template ]; then
    envsubst '$PORT' < /app/nginx.conf.template > /etc/nginx/sites-enabled/default
fi

# 3. 运行引导初始化脚本（如首次启动逻辑）
if [ -f /app/panel-bootstrap.sh ]; then
    bash /app/panel-bootstrap.sh
fi

# 4. 启动 Nginx 反向代理
echo "[INFO] 正在启动入口 Nginx 服务..."
nginx

# 5. 启动通用代理面板主进程
echo "[INFO] 正在启动 3X-UI 主服务..."
exec /usr/local/x-ui/x-ui
