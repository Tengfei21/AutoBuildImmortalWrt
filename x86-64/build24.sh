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
# LuCI 插件语言包（只保留实际用到主包的语言包）
PACKAGES="$PACKAGES luci-i18n-diskman-zh-cn"
PACKAGES="$PACKAGES luci-i18n-firewall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-argon-config-zh-cn"
PACKAGES="$PACKAGES luci-i18n-package-manager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-ttyd-zh-cn"
PACKAGES="$PACKAGES luci-i18n-passwall-zh-cn"
PACKAGES="$PACKAGES luci-i18n-homeproxy-zh-cn"
PACKAGES="$PACKAGES luci-i18n-filemanager-zh-cn"
PACKAGES="$PACKAGES luci-i18n-dufs-zh-cn"
# LuCI 主题与配置
PACKAGES="$PACKAGES luci-theme-argon"
PACKAGES="$PACKAGES luci-app-argon-config"
PACKAGES="$PACKAGES luci-app-package-manager"
PACKAGES="$PACKAGES luci-app-firewall"
# 文件管理/浏览器（只保留 filebrowser-go，删除 filemanager）
PACKAGES="$PACKAGES luci-app-filebrowser-go"
# QoS/网络插件
PACKAGES="$PACKAGES luci-app-eqos"
PACKAGES="$PACKAGES luci-app-3cat"
# VPN 和代理
PACKAGES="$PACKAGES luci-app-openvpn-server"
PACKAGES="$PACKAGES luci-app-openclash"
PACKAGES="$PACKAGES luci-app-passwall"
# 网络监控和管理
PACKAGES="$PACKAGES luci-app-nlbwmon"
PACKAGES="$PACKAGES luci-app-mwan3"
PACKAGES="$PACKAGES luci-app-ddns"
PACKAGES="$PACKAGES luci-app-ddns-go"
PACKAGES="$PACKAGES luci-app-arpbind"
PACKAGES="$PACKAGES luci-app-cpulimit"
# 云和远程访问
PACKAGES="$PACKAGES luci-app-frps"
PACKAGES="$PACKAGES luci-app-frpc"
PACKAGES="$PACKAGES luci-app-cloudflared"
# 文件共享和存储（samba4/ksmbd二选一，这里保留samba4）
PACKAGES="$PACKAGES luci-app-samba4"
# PACKAGES="$PACKAGES luci-app-ksmbd"   # 已删除
PACKAGES="$PACKAGES luci-app-rclone"
PACKAGES="$PACKAGES luci-app-cifs-mount"
PACKAGES="$PACKAGES luci-app-diskman"
PACKAGES="$PACKAGES luci-app-dufs"
PACKAGES="$PACKAGES luci-app-ramfree"
PACKAGES="$PACKAGES luci-app-pbr"
PACKAGES="$PACKAGES luci-app-nut"
PACKAGES="$PACKAGES luci-app-daed"
# 其他服务
PACKAGES="$PACKAGES luci-app-p910nd"
# PACKAGES="$PACKAGES luci-app-openlist"   # 已删除
PACKAGES="$PACKAGES luci-app-airplay2"     # 如有报错可注释
PACKAGES="$PACKAGES luci-app-acme"
PACKAGES="$PACKAGES luci-app-aria2"
PACKAGES="$PACKAGES luci-app-dockerman"
# 系统管理
PACKAGES="$PACKAGES luci-app-msd_lite"
PACKAGES="$PACKAGES luci-app-nps"
# 无线相关（只保留wpad，功能最全，其他全部注释）
PACKAGES="$PACKAGES wpad"
# PACKAGES="$PACKAGES wpad-basic"
# PACKAGES="$PACKAGES wpad-basic-mbedtls"
# PACKAGES="$PACKAGES wpad-basic-openssl"
# PACKAGES="$PACKAGES wpad-basic-wolfssl"
# PACKAGES="$PACKAGES wpad-mbedtls"
# PACKAGES="$PACKAGES wpad-mesh-mbedtls"
# PACKAGES="$PACKAGES wpad-mesh-openssl"
# PACKAGES="$PACKAGES wpad-mesh-wolfssl"
# PACKAGES="$PACKAGES wpad-mini"
# PACKAGES="$PACKAGES wpad-openssl"
# PACKAGES="$PACKAGES wpad-wolfssl"
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
# 编辑器（只保留vim）
PACKAGES="$PACKAGES vim"
# PACKAGES="$PACKAGES vim-runtime"
# PACKAGES="$PACKAGES vim-help"
# PACKAGES="$PACKAGES vim-fuller"
# PACKAGES="$PACKAGES vim-full"
# 权限管理/工具
PACKAGES="$PACKAGES sudo"
PACKAGES="$PACKAGES nano"
PACKAGES="$PACKAGES mc"
PACKAGES="$PACKAGES sed"
PACKAGES="$PACKAGES awk"
# 网络检测工具
PACKAGES="$PACKAGES traceroute"
PACKAGES="$PACKAGES mtr"
PACKAGES="$PACKAGES iftop"
PACKAGES="$PACKAGES ip"
PACKAGES="$PACKAGES curl"
PACKAGES="$PACKAGES wget"
PACKAGES="$PACKAGES scp"
PACKAGES="$PACKAGES rsync"
PACKAGES="$PACKAGES tcpdump"
PACKAGES="$PACKAGES nslookup"
PACKAGES="$PACKAGES nmap"
PACKAGES="$PACKAGES bmon"
PACKAGES="$PACKAGES fping"
PACKAGES="$PACKAGES iwinfo"
PACKAGES="$PACKAGES luci-app-statistics"
# Python 相关
PACKAGES="$PACKAGES libpython3-3.11"
PACKAGES="$PACKAGES python3-xml"
PACKAGES="$PACKAGES python3-uuid"
PACKAGES="$PACKAGES python3-urllib"
PACKAGES="$PACKAGES python3-unittest"
PACKAGES="$PACKAGES python3-sqlite3"
PACKAGES="$PACKAGES python3-readline"
PACKAGES="$PACKAGES python3-pydoc"
PACKAGES="$PACKAGES python3-pkg-resources"
PACKAGES="$PACKAGES python3-pip"
PACKAGES="$PACKAGES python3-openssl"
PACKAGES="$PACKAGES python3-ncurses"
PACKAGES="$PACKAGES python3-multiprocessing"
PACKAGES="$PACKAGES python3-lzma"
PACKAGES="$PACKAGES python3-logging"
PACKAGES="$PACKAGES python3-light"
PACKAGES="$PACKAGES python3-email"
PACKAGES="$PACKAGES python3-distutils"
PACKAGES="$PACKAGES python3-decimal"
PACKAGES="$PACKAGES python3-dbm"
PACKAGES="$PACKAGES python3-curl-src"
PACKAGES="$PACKAGES python3-curl"
PACKAGES="$PACKAGES python3-ctypes"
PACKAGES="$PACKAGES python3-codecs"
PACKAGES="$PACKAGES python3-cgitb"
PACKAGES="$PACKAGES python3-cgi"
PACKAGES="$PACKAGES python3-base"
PACKAGES="$PACKAGES python3-asyncio"
PACKAGES="$PACKAGES python3"
# PHP 相关
PACKAGES="$PACKAGES php8-mod-zip"
PACKAGES="$PACKAGES php8-mod-xmlwriter"
PACKAGES="$PACKAGES php8-mod-xmlreader"
PACKAGES="$PACKAGES php8-mod-xml"
PACKAGES="$PACKAGES php8-mod-sqlite3"
PACKAGES="$PACKAGES php8-mod-session"
PACKAGES="$PACKAGES php8-mod-pdo-sqlite"
PACKAGES="$PACKAGES php8-mod-pdo-mysql"
PACKAGES="$PACKAGES php8-mod-pdo"
PACKAGES="$PACKAGES php8-mod-openssl"
PACKAGES="$PACKAGES php8-mod-opcache"
PACKAGES="$PACKAGES php8-mod-mysqlnd"
PACKAGES="$PACKAGES php8-mod-mbstring"
PACKAGES="$PACKAGES php8-mod-iconv"
PACKAGES="$PACKAGES php8-mod-gd"
PACKAGES="$PACKAGES php8-mod-dom"
PACKAGES="$PACKAGES php8-mod-curl"
PACKAGES="$PACKAGES php8-fpm"
PACKAGES="$PACKAGES php8-fastcgi"
PACKAGES="$PACKAGES php8-cgi"
PACKAGES="$PACKAGES php8"
# SSH 服务
PACKAGES="$PACKAGES openssh-sftp-server"
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
