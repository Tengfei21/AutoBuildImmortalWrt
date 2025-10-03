#!/bin/bash
# ==================== IMM仓库外的第三方插件 ====================
# 如果你构建的固件是硬路由设备，注释此文件时要谨慎。
# 硬路由设备的闪存空间有限，构建失败时，可以考虑减少此文件中的插件。
# 目前，集成 iStore 商店插件的操作已经放置在工作流的 UI 选项中，用户可以自行勾选，减少修改此文件的频率。

# ==================== 首页和网络向导 ====================
# 初始配置和向导界面，支持中文
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-quickstart-zh-cn" # 首页快速配置

# ==================== 去广告功能 ====================
# 集成 AdGuardHome 用于网络广告拦截
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adguardhome" # 广告拦截

# ==================== 代理相关功能 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-passwall-zh-cn" # Passwall 插件中文包
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ssr-plus"         # SSR Plus 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-passwall2"        # Passwall2 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-nikki-zh-cn"    # Nikki 插件中文包
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nekobox"          # Nekobox 插件

# 以下两个插件为 IMM 仓库内的插件，通常在 build24.sh 中已集成，若需要手动修改，可以排除它们。
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-app-openclash"        # OpenClash 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-i18n-homeproxy-zh-cn" # HomeProxy 插件中文包

# ==================== VPN 和网络加速 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-tailscale"         # Tailscale 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-tailscale-zh-cn"  # Tailscale 中文包
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-partexp"           # 分区扩容工具

# ==================== 主题和界面 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-theme-kucat"           # 酷猫主题

# ==================== 进阶设置 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-advancedplus"      # 进阶设置插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-advancedplus-zh-cn" # 进阶设置插件中文包
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-app-argon-config"     # 排除 Argon 配置插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-i18n-argon-config-zh-cn" # 排除 Argon 配置中文包

# ==================== 网络测速 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netspeedtest"      # 网络测速插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-netspeedtest-zh-cn" # 网络测速插件中文包

# ==================== MosDNS ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mosdns"            # MosDNS 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-mosdns-zh-cn"     # MosDNS 插件中文包

# ==================== 网络加速 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-turboacc"          # Turbo ACC 插件

# ==================== 应用过滤 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-appfilter"         # 应用过滤插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-appfilter-zh-cn"  # 应用过滤插件中文包

# ==================== 设置向导 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netwizard"         # 网络向导插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-netwizard-zh-cn"  # 网络向导插件中文包

# ==================== Lucky 大吉 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-lucky"             # Lucky 大吉插件

# ==================== 集客AC ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-gecoosac"          # 集客AC 插件

# ==================== 任务设置 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-taskplan"          # 任务计划插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-taskplan-zh-cn"   # 任务计划插件中文包

# ==================== Easytier ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES easytier"                   # Easytier 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-easytier"          # Easytier luci 插件

# ==================== 统一文件共享 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES webdav2"                    # WebDAV 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-unishare"          # UniShare 插件

# ==================== 更多插件 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adbyby-plus"       # Adbyby Plus 广告拦截插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-airplay2"          # AirPlay 2 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-aliyundrive-webdav" # 阿里云盘 WebDAV 客户端
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ap-modem"          # AP 模式设置插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-aria2"            # Aria2 下载管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-arpbind"           # ARP 绑定插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-bandix"            # 带宽监控插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-broadbandacc"      # 宽带加速插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cifs-mount"        # CIFS 文件共享插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-clouddrive2"       # 云盘管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cpulimit"          # CPU 限制工具
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cloudreve"         # Cloudreve 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-daed"              # 存储管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddnsto"            # DDNSTO 插件（动态 DNS）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddns"              # 动态 DNS 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddns-go"           # Go版动态 DNS 客户端
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-diskman"           # 磁盘管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-dufs"              # DUFS 文件系统插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-easymesh"          # EasyMesh 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-eqosplus"          # 网络带宽和流量管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-filebrowser"       # 文件浏览器插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-frpc"              # FRP 客户端插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-frps"              # FRP 服务器插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-guest-wifi"        # 客户端隔离 WiFi 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-homeassistant"     # Home Assistant 集成插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ipsec-server"      # IPsec VPN 服务器插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-kodexplorer"       # KodExplorer 文件管理器
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ksmbd"             # ksmbd 插件（Samba 协议）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-linkease"          # LinkEase 文件分享插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-lucky"             # Lucky 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mosdns"            # MosDNS 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-msd_lite"          # MSD Lite 插件（磁盘管理）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mwan3"             # MWAN3 插件（多 WAN 负载均衡）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-my-dnshelper"     # My DNS Helper 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-natmap"            # NAT 映射插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nft-timecontrol"   # 网络流量时间控制插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-npc"              # NPC 插件（网络访问控制）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netspeedtest"      # 网络测速插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nlbwmon"           # 网络带宽监控插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openvpn"           # OpenVPN 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-pairing"           # 设备配对插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-pihole"            # PiHole 插件（广告拦截）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-privoxy"           # Privoxy 插件（代理工具）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-quantumult"        # Quantumult 插件（代理工具）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ramfree"           # 内存管理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-raspberrypi"       # 树莓派支持插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-samba"             # Samba 文件共享插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-smartdns"          # SmartDNS 插件（智能 DNS）
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-squid"             # Squid 代理插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-tailscale"         # Tailscale 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-upnp"              # UPnP 插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-wifischedule"      # WiFi 调度插件

# ==================== 结束 ====================
# 完成插件配置，后续构建会根据以上配置安装相应插件
