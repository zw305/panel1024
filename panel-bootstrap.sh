#!/usr/bin/env bash
set -e

echo "=========================================="
echo " [INFO] 正在执行 3X-UI 面板初始化引导..."
echo "=========================================="

# 1. 确保 3X-UI 所需的数据和配置目录存在
mkdir -p /etc/x-ui
mkdir -p /usr/local/x-ui/bin

# 2. 如果你需要自定义一些默认的初始化动作，可以在这里添加
# 例如检查关键配置文件或环境变量
if [ -n "${CUSTOM_INIT_MSG}" ]; then
    echo "[INFO] 自定义提示: ${CUSTOM_INIT_MSG}"
fi

echo " [INFO] 初始化引导完成，准备启动服务..."
echo "=========================================="
