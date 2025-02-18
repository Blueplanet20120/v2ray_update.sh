#!/bin/bash
#只能x86-64的openwrt系统上，更新lean大佬的XXXPLUS的v2插件！
#	bash -c "$(wget -O- https://git.io/JvTOE)"
#By Len yu
	 cd /tmp/tmp
	 rm -rf *
	 echo -e " $green 运行前检查..$none"
	 clear
	 echo
	 echo 
	 st=0`ps | grep "passwall" | awk '{print $8}'`  &> /dev/null
	 if [ 0`echo ${st: 10:8}` =  0passwall ]; then
		echo -e " 请先关闭passwall并启动lean大佬的SSRPULS+，并选择v2ray方式启动再试!" 
		echo
		exit 0
	 fi
	 echo
	 sr=0`ps -ef | grep "/var/etc/v2-ssr" | awk '{print $7}'` &> /dev/null
	 if [ $sr != "0/var/etc/v2-ssr-retcp.json" ]; then
		clear
		echo
		echo -e " $green 请先启动lean大佬的SSRPULS+，并选择v2ray方式启动后再试！$none"
		exit 0
	 fi
	 echo -e " $green 1.正在获取网络最新版信息..$none"
	 echo
	 echo -e " $green 2.只能x86-64的openwrt系统上，更新lean大佬的XXXPLUS的v2插件！$none"
	v2ray_latest_ver="$(curl -H 'Cache-Control: no-cache' -s https://api.github.com/repos/v2ray/v2ray-core/releases/latest | grep 'tag_name' | cut -d\" -f4)" && sleep 2
	v2ray_ver=v`/usr/bin/v2ray/v2ray -version | grep "V2" | awk '{print $2}'`   &> /dev/null
	if [ $v2ray_ver != $v2ray_latest_ver ]; then
		clear
		echo
		echo -e " $green 咦...发现新版本耶....正在拼命更新.......$none"
		echo
		v2ray_download_link="https://github.com/v2ray/v2ray-core/releases/download/$v2ray_latest_ver/v2ray-linux-64.zip"
		echo
		echo
		wget  "$v2ray_download_link"
		unzip -o v2ray-linux-64.zip &> /dev/null
		echo
	else
		clear
		echo
		echo -e " $green 木有发现新版本....$none"
		echo
		exit 0
	fi
    if [ -e /tmp/tmp/v2ray ]; then
		mv -f /tmp/tmp/v2ctl  /usr/bin/v2ray
		mv -f /tmp/tmp/v2ray  /usr/bin/v2ray
		chmod 755 /usr/bin/v2ray/v2ctl
		chmod 755 /usr/bin/v2ray/v2ray
		/etc/init.d/shadowsocksr restart
		echo
        	echo -e " $green 更新成功啦...当前 V2Ray 版本: ${cyan}$v2ray_latest_ver$none"
		echo
		echo -e " $yellow 温馨提示: 为了避免出现莫名其妙的问题...V2Ray 客户端的版本最好和服务器的版本保持一致$none"
		echo
		echo  -e " $yellow 请到路由后台程序保存应用一下XXSSRplus+，确保成功应用！$none"
		echo
		exit 0
    else
		echo
        echo -e "
        $red 下载 V2Ray 失败啦..可能是你的 VPS 网络太辣鸡了...请重试...$none
        " && exit 0
    fi
