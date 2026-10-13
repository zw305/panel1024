#!/usr/bin/env bash
set -e

# 1. 获取动态端口
PORT="${PORT:-8080}"
echo "[INFO] 当前平台分配运行端口: ${PORT}"

# 2. 渲染 Nginx 配置
export PORT
if [ -f /app/nginx.conf.template ]; then
    envsubst '$PORT' < /app/nginx.conf.template > /etc/nginx/sites-enabled/default
fi

# 3. 运行引导脚本
if [ -f /app/panel-bootstrap.sh ]; then
    bash /app/panel-bootstrap.sh
fi

# 4. 切换到 3X-UI 安装目录并创建 bin 文件夹
cd /usr/local/x-ui
mkdir -p bin
chmod -R 777 bin

# 5. 启动 Nginx
echo "[INFO] 正在启动入口 Nginx 服务..."
nginx

# 6. 启动 3X-UI 主服务
echo "[INFO] 正在启动 3X-UI 主服务..."
exec /usr/local/x-ui/x-ui
