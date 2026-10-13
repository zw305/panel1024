#!/usr/bin/env bash
set -e

echo "[INFO] 正在初始化 3X-UI 运行环境..."

# 创建 3X-UI 核心所需的 bin 目录
mkdir -p /usr/local/x-ui/bin
chmod -R 777 /usr/local/x-ui/bin

echo "[INFO] 初始化完成！"
