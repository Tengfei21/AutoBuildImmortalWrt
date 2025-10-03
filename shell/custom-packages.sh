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

# ==================== 进阶设置 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-advancedplus"      # 进阶设置插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-advancedplus-zh-cn" # 进阶设置插件中文包
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-app-argon-config"     # 排除 Argon 配置插件
CUSTOM_PACKAGES="$CUSTOM_PACKAGES -luci-i18n-argon-config-zh-cn" # 排除 Argon 配置中文包

# ==================== 网络与功能 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-zerotier"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-xunyou"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-apfree-wifidog"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-webdav"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-watchcat"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-vsftpd"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-vlmcsd"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-uugamebooster"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-unishare"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-unblockneteasemusic"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-transmission"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-timecontrol"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-thunder"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-syncdial"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-subconverter"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-store"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cupsd"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-sqm-autorate"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-softethervpn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-socat"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-smartdns"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-wechatpush"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-samba4"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-rclone"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-qosmate"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-qbittorrent"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-partexp"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-parentcontrol"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openvpn-server-client"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openlist2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES BaiduPCS-Go"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-oaf"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netspeedtest"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-npc"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nft-timecontrol"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-natmap"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mwan3helper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-msd_lite"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-lucky"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ksmbd"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-kodexplorer"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ipsec-server"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-homeassistant"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-guest-wifi"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-frps"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-frpc"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-eqosplus"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-easytier"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-easymesh"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-dufs"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-diskman"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddns-go"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ddns"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-dae"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-daed"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cloudreve"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cpulimit"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-clouddrive2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-cifs-mount"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-broadbandacc"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-arpbind"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-aria2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ap-modem"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-airplay"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-accesscontrol-plus"

# ==================== 依赖与扩展包 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES autoshare-samba"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES my-dnshelper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES linkease"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES autoshare-ksmbd"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES ddnsto"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES clouddrive2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES bandix"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES aliyundrive-webdav"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES adbyby"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-istorex"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES iptvhelper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-iptvhelper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES tvhelper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES naiveproxy"

# ==================== LuCI/其它插件与语言包 ====================
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ssr-plus"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-passwall2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-nikki-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nekobox"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-tailscale"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-tailscale-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-advancedplus"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-advancedplus-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-netspeedtest-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-mosdns"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-mosdns-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-turboacc"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-appfilter"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-appfilter-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netwizard"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-netwizard-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-gecoosac"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-taskplan"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-i18n-taskplan-zh-cn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES easytier"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES webdav2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-adbyby-plus"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-airplay2"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-aliyundrive-webdav"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-bandix"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-filebrowser"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-linkease"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-my-dnshelper"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-netdata"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-nlbwmon"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-openvpn"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-pairing"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-pihole"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-privoxy"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-quantumult"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-ramfree"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-raspberrypi"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-samba"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-squid"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-upnp"
CUSTOM_PACKAGES="$CUSTOM_PACKAGES luci-app-wifischedule"

# ==================== 使用说明 ====================
# 可直接在 OpenWrt/ImmortalWrt 自动化脚本中引用 $CUSTOM_PACKAGES
# 如需增删包，直接增删本文件对应行即可

# ==================== 结束 ====================
# 完成插件配置，后续构建会根据以上配置安装相应插件
