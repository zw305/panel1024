# =====================================================================
# 通用代理面板容器（适配 Railway 及各类 PaaS 云平台）
# 构建: docker build -t panel1024 .
# 运行: docker run -p 8080:8080 panel1024
# =====================================================================
FROM ubuntu:22.04

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

# ---- 1. 安装通用系统依赖与网络工具 ----
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        tzdata \
        nginx \
        gettext-base \
        jq \
        openssl \
        procps \
        git \
    && rm -rf /var/lib/apt/lists/*

# ---- 2. 安装 3X-UI 官方发行版（集成通用多协议内核）----
RUN curl -fsSL -o /tmp/x-ui.tar.gz \
        "https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz" \
    && tar -zxf /tmp/x-ui.tar.gz -C /tmp \
    && XUI_DIR="$(find /tmp -maxdepth 2 -type f -name 'x-ui' -print -quit | xargs dirname)" \
    && mv "${XUI_DIR}" /usr/local/x-ui \
    && chmod +x /usr/local/x-ui/x-ui \
    && rm -rf /tmp/* /tmp/.[!.]* /tmp/..?*

# ---- 3. 应用脚本与通用配置 ----
WORKDIR /app
COPY start.sh panel-bootstrap.sh nginx.conf.template /app/
RUN chmod +x /app/start.sh /app/panel-bootstrap.sh

ENV XUI_BIN=/usr/local/x-ui/x-ui

# 兼容 Railway 等平台动态注入 PORT
EXPOSE 8080

ENTRYPOINT ["/app/start.sh"]
