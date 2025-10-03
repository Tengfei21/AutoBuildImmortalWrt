#!/bin/bash
# Log file for debugging
source shell/custom-packages.sh
echo "第三方软件包: $CUSTOM_PACKAGES"
LOGFILE="/tmp/uci-defaults-log.txt"
echo "Starting 99-custom.sh at $(date)" >> $LOGFILE
echo "编译固件大小为: $PROFILE MB"
echo "Include Docker: $INCLUDE_DOCKER"

echo "Create pppoe-settings"
mkdir -p  /home/build/immortalwrt/files/etc/config

# 创建pppoe配置文件 yml传入环境变量ENABLE_PPPOE等 写入配置文件 供99-custom.sh读取
cat << EOF > /home/build/immortalwrt/files/etc/config/pppoe-settings
enable_pppoe=${ENABLE_PPPOE}
pppoe_account=${PPPOE_ACCOUNT}
pppoe_password=${PPPOE_PASSWORD}
EOF

echo "cat pppoe-settings"
cat /home/build/immortalwrt/files/etc/config/pppoe-settings

if [ -z "$CUSTOM_PACKAGES" ]; then
  echo "⚪️ 未选择 任何第三方软件包"
else
  # ============= 同步第三方插件库==============
  # 同步第三方软件仓库run/ipk
  echo "🔄 正在同步第三方软件仓库 Cloning run file repo..."
  git clone --depth=1 https://github.com/wukongdaily/store.git /tmp/store-run-repo

  # 拷贝 run/x86 下所有 run 文件和ipk文件 到 extra-packages 目录
  mkdir -p /home/build/immortalwrt/extra-packages
  cp -r /tmp/store-run-repo/run/x86/* /home/build/immortalwrt/extra-packages/

  echo "✅ Run files copied to extra-packages:"
  ls -lh /home/build/immortalwrt/extra-packages/*.run
  # 解压并拷贝ipk到packages目录
  sh shell/prepare-packages.sh
  ls -lah /home/build/immortalwrt/packages/
fi

# 输出调试信息
echo "$(date '+%Y-%m-%d %H:%M:%S') - 开始构建固件..."

# ============= imm仓库内的插件==============
# 定义所需安装的包列表 下列插件你都可以自行删减
PACKAGES=""
# LuCI 插件语言包（中文）
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES luci-i18n-samba4-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filemanager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-dufs-zh-cn"
# LuCI 主题
PACKAGES="$PACKAGES luci-theme-argon"        # Argon主题
# LuCI 配置插件
PACKAGES="$PACKAGES luci-app-argon-config"   # Argon配置插件
PACKAGES="$PACKAGES luci-app-package-manager" # 包管理插件
PACKAGES="$PACKAGES luci-app-firewall"       # 防火墙插件
PACKAGES="$PACKAGES luci-app-filemanager"    # 文件管理插件
PACKAGES="$PACKAGES luci-app-filebrowser-go" # 文件浏览器插件
PACKAGES="$PACKAGES luci-app-eqos"           # QoS 插件
PACKAGES="$PACKAGES luci-app-3cat"           # 3cat 插件
# VPN 和代理插件
PACKAGES="$PACKAGES luci-app-openvpn-server" # OpenVPN 服务器插件
PACKAGES="$PACKAGES luci-app-openclash"      # Clash 插件
PACKAGES="$PACKAGES luci-app-passwall"       # Passwall 插件
# 网络监控和管理
PACKAGES="$PACKAGES luci-app-nlbwmon"       # 网络带宽监控插件
PACKAGES="$PACKAGES luci-app-mwan3"          # 多WAN管理插件
PACKAGES="$PACKAGES luci-app-ddns"           # DDNS 插件
PACKAGES="$PACKAGES luci-app-ddns-go"        # Go版 DDNS 插件
PACKAGES="$PACKAGES luci-app-arpbind"        # ARP绑定插件
PACKAGES="$PACKAGES luci-app-nt"             # 网络时钟插件
PACKAGES="$PACKAGES luci-app-cpulimit"       # CPU 限制插件
# 云和远程访问插件
PACKAGES="$PACKAGES luci-app-frps"           # FRP 服务端插件
PACKAGES="$PACKAGES luci-app-frpc"           # FRP 客户端插件
PACKAGES="$PACKAGES luci-app-cloudflared"    # Cloudflare 插件
# 文件管理和共享插件
PACKAGES="$PACKAGES luci-app-samba4"        # Samba4 文件共享
PACKAGES="$PACKAGES luci-app-rclone"         # Rclone 云存储挂载
PACKAGES="$PACKAGES luci-app-minidlna"       # MiniDLNA 媒体服务器
PACKAGES="$PACKAGES luci-app-ksmbd"          # ksmbd 文件共享插件
PACKAGES="$PACKAGES luci-app-cifs-mount"     # CIFS 挂载插件
PACKAGES="$PACKAGES luci-app-filemanager"    # 文件管理插件
PACKAGES="$PACKAGES luci-app-filebrowser-go" # 文件浏览器插件
# 存储相关插件
PACKAGES="$PACKAGES luci-app-diskman"        # 磁盘管理插件
PACKAGES="$PACKAGES luci-app-dufs"           # DUFS 文件系统插件
PACKAGES="$PACKAGES luci-app-ramfree"       # 内存释放插件
PACKAGES="$PACKAGES luci-app-pbr"            # 路由选择器插件
PACKAGES="$PACKAGES luci-app-nut"            # 网络UPS插件
PACKAGES="$PACKAGES luci-app-daed"           # 防止设备休眠插件
PACKAGES="$PACKAGES luci-app-cpulimit"       # CPU限制插件
# 其他服务和工具
PACKAGES="$PACKAGES luci-app-p910nd"         # P910nd 打印服务插件
PACKAGES="$PACKAGES luci-app-openlist"       # Openlist 插件
PACKAGES="$PACKAGES luci-app-airplay2"       # AirPlay 2 插件
PACKAGES="$PACKAGES luci-app-acme"           # ACME 插件（自动化证书管理）
PACKAGES="$PACKAGES luci-app-aria2"          # Aria2 下载管理插件
PACKAGES="$PACKAGES luci-app-dockerman"      # Docker 管理插件
# 系统管理插件
PACKAGES="$PACKAGES luci-app-msd_lite"      # MSD Lite 插件（小型文件服务器）
PACKAGES="$PACKAGES luci-app-openlist"       # Openlist 插件
PACKAGES="$PACKAGES luci-app-nps"            # NPS 插件（内网穿透）
# 无线相关
PACKAGES="$PACKAGES wpad"
PACKAGES="$PACKAGES wpad-basic"
PACKAGES="$PACKAGES wpad-basic-mbedtls"
PACKAGES="$PACKAGES wpad-basic-openssl"
PACKAGES="$PACKAGES wpad-basic-wolfssl"
PACKAGES="$PACKAGES wpad-mbedtls"
PACKAGES="$PACKAGES wpad-mesh-mbedtls"
PACKAGES="$PACKAGES wpad-mesh-openssl"
PACKAGES="$PACKAGES wpad-mesh-wolfssl"
PACKAGES="$PACKAGES wpad-mini"
PACKAGES="$PACKAGES wpad-openssl"
PACKAGES="$PACKAGES wpad-wolfssl"
PACKAGES="$PACKAGES wireless-regdb"
PACKAGES="$PACKAGES wireless-tools"
PACKAGES="$PACKAGES wifi-presence"
PACKAGES="$PACKAGES wifi-scripts"
PACKAGES="$PACKAGES wifischedule"
PACKAGES="$PACKAGES wifitoggle"
# 无线网卡驱动
PACKAGES="$PACKAGES mt7921bt-firmware"
PACKAGES="$PACKAGES kmod-mt7921-common"
PACKAGES="$PACKAGES kmod-mt7921-firmware"
PACKAGES="$PACKAGES kmod-mt7921e"
PACKAGES="$PACKAGES kmod-mt7921s"
PACKAGES="$PACKAGES kmod-mt7921u"
# 虚拟化支持
PACKAGES="$PACKAGES open-vm-tools-fuse"
PACKAGES="$PACKAGES open-vm-tools"
PACKAGES="$PACKAGES kmod-kvm-x86"
PACKAGES="$PACKAGES kmod-kvm-intel"
PACKAGES="$PACKAGES kmod-kvm-amd"
PACKAGES="$PACKAGES kmod-drm-i915"
PACKAGES="$PACKAGES i915-firmware-huc"
PACKAGES="$PACKAGES i915-firmware-guc"
PACKAGES="$PACKAGES i915-firmware-gsc"
PACKAGES="$PACKAGES i915-firmware-dmc"
PACKAGES="$PACKAGES i915-firmware"
# Vim 编辑器及其相关包
PACKAGES="$PACKAGES vim-runtime"
PACKAGES="$PACKAGES vim-help"
PACKAGES="$PACKAGES vim-fuller"
PACKAGES="$PACKAGES vim-full"
PACKAGES="$PACKAGES vim"
# sudo 权限管理
PACKAGES="$PACKAGES sudo"
# 文件编辑工具
PACKAGES="$PACKAGES nano"  # 简单易用的文本编辑器
PACKAGES="$PACKAGES mc"    # Midnight Commander 文件管理器，带文本编辑功能
PACKAGES="$PACKAGES sed"   # 流编辑工具，适合快速文本替换
PACKAGES="$PACKAGES awk"   # 文本数据处理工具
# 网络检测工具
PACKAGES="$PACKAGES traceroute"  # 路由追踪工具
PACKAGES="$PACKAGES mtr"        # 结合 ping 和 traceroute 功能的网络监测工具
PACKAGES="$PACKAGES iftop"      # 实时网络流量监控
PACKAGES="$PACKAGES ip"         # 强大的网络配置工具
PACKAGES="$PACKAGES curl"       # 下载工具，类似 wget
PACKAGES="$PACKAGES wget"       # 下载工具，类似 curl
PACKAGES="$PACKAGES scp"        # 用于通过SSH进行远程复制文件的命令行工具
PACKAGES="$PACKAGES rsync"      # 高效的文件传输和同步工具，适合大规模文件管理和备份
PACKAGES="$PACKAGES tcpdump"    # 网络数据包抓取工具
PACKAGES="$PACKAGES nslookup"   # DNS 查询工具
PACKAGES="$PACKAGES nmap"       # 网络扫描工具
PACKAGES="$PACKAGES bmon"       # 带宽监控工具
PACKAGES="$PACKAGES fping"      # 高效的 ping 工具
PACKAGES="$PACKAGES iwinfo"     # 无线网络接口信息获取工具
PACKAGES="$PACKAGES luci-app-statistics"  # 网络使用和带宽统计图形化展示
# Python 相关工具和库
PACKAGES="$PACKAGES libpython3-3.11"           # Python 3.11 运行时库
PACKAGES="$PACKAGES python3-xml"               # Python 3 XML 模块
PACKAGES="$PACKAGES python3-uuid"              # Python 3 UUID 模块
PACKAGES="$PACKAGES python3-urllib"            # Python 3 urllib 模块
PACKAGES="$PACKAGES python3-unittest"          # Python 3 unittest 模块
PACKAGES="$PACKAGES python3-sqlite3"           # Python 3 SQLite3 模块
PACKAGES="$PACKAGES python3-readline"          # Python 3 readline 模块
PACKAGES="$PACKAGES python3-pydoc"             # Python 3 文档生成工具
PACKAGES="$PACKAGES python3-pkg-resources"     # Python 3 setuptools 模块
PACKAGES="$PACKAGES python3-pip"               # Python 3 pip 工具
PACKAGES="$PACKAGES python3-openssl"           # Python 3 OpenSSL 模块
PACKAGES="$PACKAGES python3-ncurses"           # Python 3 ncurses 模块
PACKAGES="$PACKAGES python3-multiprocessing"   # Python 3 多进程模块
PACKAGES="$PACKAGES python3-lzma"              # Python 3 lzma 模块
PACKAGES="$PACKAGES python3-logging"           # Python 3 日志模块
PACKAGES="$PACKAGES python3-light"             # Python 3 light 模块
PACKAGES="$PACKAGES python3-email"             # Python 3 邮件模块
PACKAGES="$PACKAGES python3-distutils"         # Python 3 distutils 模块
PACKAGES="$PACKAGES python3-decimal"           # Python 3 decimal 模块
PACKAGES="$PACKAGES python3-dbm"               # Python 3 dbm 模块
PACKAGES="$PACKAGES python3-curl-src"          # PycURL：Python 接口与 libcurl
PACKAGES="$PACKAGES python3-curl"              # PycURL：Python 接口与 libcurl
PACKAGES="$PACKAGES python3-ctypes"            # Python 3 ctypes 模块
PACKAGES="$PACKAGES python3-codecs"            # Python 3 codecs 模块
PACKAGES="$PACKAGES python3-cgitb"             # Python 3 cgitb 模块
PACKAGES="$PACKAGES python3-cgi"               # Python 3 cgi 模块
PACKAGES="$PACKAGES python3-base"              # Python 3 基础模块
PACKAGES="$PACKAGES python3-asyncio"           # Python 3 asyncio 模块
PACKAGES="$PACKAGES python3"                   # Python 3 基础安装包
# PHP 相关工具和库
PACKAGES="$PACKAGES php8-mod-zip"              # PHP 8 zip 模块
PACKAGES="$PACKAGES php8-mod-xmlwriter"        # PHP 8 XMLWriter 模块
PACKAGES="$PACKAGES php8-mod-xmlreader"        # PHP 8 XMLReader 模块
PACKAGES="$PACKAGES php8-mod-xml"              # PHP 8 XML 模块
PACKAGES="$PACKAGES php8-mod-sqlite3"          # PHP 8 SQLite3 模块
PACKAGES="$PACKAGES php8-mod-session"          # PHP 8 Session 模块
PACKAGES="$PACKAGES php8-mod-pdo-sqlite"       # PHP 8 PDO SQLite3 模块
PACKAGES="$PACKAGES php8-mod-pdo-mysql"        # PHP 8 PDO MySQL 模块
PACKAGES="$PACKAGES php8-mod-pdo"              # PHP 8 PDO 模块
PACKAGES="$PACKAGES php8-mod-openssl"          # PHP 8 OpenSSL 模块
PACKAGES="$PACKAGES php8-mod-opcache"          # PHP 8 OPcache 模块
PACKAGES="$PACKAGES php8-mod-mysqlnd"          # PHP 8 MySQL Native Driver 模块
PACKAGES="$PACKAGES php8-mod-mbstring"         # PHP 8 MBString 模块
PACKAGES="$PACKAGES php8-mod-iconv"            # PHP 8 iconv 模块
PACKAGES="$PACKAGES php8-mod-gd"               # PHP 8 GD 模块
PACKAGES="$PACKAGES php8-mod-dom"              # PHP 8 DOM 模块
PACKAGES="$PACKAGES php8-mod-curl"             # PHP 8 cURL 模块
PACKAGES="$PACKAGES php8-fpm"                  # PHP 8 FPM（FastCGI Process Manager）
PACKAGES="$PACKAGES php8-fastcgi"              # PHP 8 FastCGI 模块
PACKAGES="$PACKAGES php8-cgi"                  # PHP 8 CGI 模块
PACKAGES="$PACKAGES php8"                      # PHP 8 基础包
# SSH 服务相关
PACKAGES="$PACKAGES openssh-sftp-server"       # 用于通过 SFTP 协议传输文件的 SSH 服务器
# ======== shell/custom-packages.sh =======
# 合并imm仓库以外的第三方插件
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"
# ======== shell/custom-packages.sh =======
# 合并imm仓库以外的第三方插件
PACKAGES="$PACKAGES $CUSTOM_PACKAGES"


# 判断是否需要编译 Docker 插件
if [ "$INCLUDE_DOCKER" = "yes" ]; then
    PACKAGES="$PACKAGES luci-i18n-dockerman-zh-cn"
    echo "Adding package: luci-i18n-dockerman-zh-cn"
fi

# 若构建openclash 则添加内核
if echo "$PACKAGES" | grep -q "luci-app-openclash"; then
    echo "✅ 已选择 luci-app-openclash，添加 openclash core"
    mkdir -p files/etc/openclash/core
    # Download clash_meta
    META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz"
    wget -qO- $META_URL | tar xOvz > files/etc/openclash/core/clash_meta
    chmod +x files/etc/openclash/core/clash_meta
    # Download GeoIP and GeoSite
    wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O files/etc/openclash/GeoIP.dat
    wget -q https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O files/etc/openclash/GeoSite.dat
else
    echo "⚪️ 未选择 luci-app-openclash"
fi

# 构建镜像
echo "$(date '+%Y-%m-%d %H:%M:%S') - Building image with the following packages:"
echo "$PACKAGES"

make image PROFILE="generic" PACKAGES="$PACKAGES" FILES="/home/build/immortalwrt/files" ROOTFS_PARTSIZE=$PROFILE

if [ $? -ne 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Error: Build failed!"
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') - Build completed successfully."
