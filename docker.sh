#!/bin/bash
VERSION="v1.0"

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

echo -e "
${yellow}
#========================================================
#   Testing environment: 
#           型号 : Phicomm N1
#           OpenWrt固件版本 : OpenWrt 10.21.2022 by Kiddin' / LuCI Master git-61f6e6d
#   Description: Docker控制台
#========================================================    
${plain}"

ps_a() {
    docker ps -a
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

stats() {
    docker stats
}

restart() {
    read -ep "请输入容器名称或者ID: " id
    docker restart ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

start() {
    read -ep "请输入容器名称或者ID: " id
    docker start ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

stop() {
    read -ep "请输入容器名称或者ID: " id
    docker stop ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

rm() {
    read -ep "请输入容器名称或者ID: " id
    docker rm -f ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

stop+rm() {
    read -ep "请输入容器名称或者ID: " id
    docker stop ${id}
    docker rm -f ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

exec() {
    read -ep "请输入容器名称或者ID: " id
    docker exec -it ${id} /bin/bash
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

update() {
    read -ep "请输入容器名称或者ID: " id
    docker run --rm     -v /var/run/docker.sock:/var/run/docker.sock     containrrr/watchtower -c     --run-once     ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

#镜像命令
images() {
    docker images
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

rm_images() {
    read -ep "请输入镜像ID前四位字符或者<仓库名>:<标签>: " id
    docker rmi -f ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}



docker_sh() {    
    echo -e "
    ${green}Docker控制台${plain}  ${red}${VERSION}${plain}
    ——容器命令——————————————-
    ${green}1.查看所有容器  2.重启容器${plain}
    ${green}3.${plain}  启动容器
    ${green}4.${plain}  停止容器
    ${green}5.${plain}  删除容器
    ${green}6.${plain}  停止并删除容器
    ${green}7.${plain}  进入容器内部
    ${green}8.${plain}  热更新容器镜像
    ——镜像命令——————————————-
    ${green}20.${plain} 查看所有镜像
    ${green}21.${plain} 删除镜像
    ${green}22.${plain} 
    ${green}23.${plain} 
    ${green}24.${plain} 
    ————————————————-
    ${green}99.${plain} 查看容器占用数据
    ————————————————-
    ${green}0.${plain}  退出脚本
    "
    read -ep "请输入编号: " num

    case "${num}" in    
    
    
    1) ps_a ;;
    2) restart ;;
    3) start ;;
    4) stop ;;
    5) rm ;;
    6) stop+rm ;;
    7) exec ;;
    8) update ;;
    20) images ;;
    21) rm_images ;;
    99)
        stats
        ;;
    0) exit 0 ;;
    *) echo && echo -n -e "${yellow}
    ====================
    * 请输入正确的编号 *
    ====================
       ${plain}"
       echo && echo -e "    ${yellow}输入0退出脚本 | 其他则继续${plain}" 
       echo && read -p "请输入编号: " tuichu;
       if [ "$tuichu" != "0" ];
       then echo ""
       docker_sh
       else 
       exit 0
       fi;
       ;;
    esac
}


docker_sh

