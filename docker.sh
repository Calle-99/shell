#!/bin/bash
VERSION="v1.1"

black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
blue='\033[34m'
yellow='\033[0;33m'
bold='\033[1m'
plain='\033[0m'

## 清屏
    clear
## Docker版本号
    docker_v=$(docker -v)
## Docker Compose版本号
    docker_compose_v=$(docker-compose -v)


#容器命令############################################################
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

always() {
    read -ep "请输入容器名称或者ID: " id
    docker update --restart=always ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

#镜像命令############################################################
images() {
    docker images
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

rm_images() {
    docker images
    read -ep "请输入镜像ID或者<仓库名>:<标签>: " id
    docker rmi -f ${id}
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

#Docker Compose命令############################################################
Compose_up_d() {
    docker-compose up -d
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

Compose_stop() {
    docker-compose stop
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

Compose_restart() {
    docker-compose restart
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

Compose_rm() {
    docker-compose rm
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}

Compose_logs_f() {
    docker-compose logs -f
    echo && echo -n -e "${yellow}* 按回车返回主菜单 *${plain}" && read temp
    docker_sh
}





docker_sh() {
    echo -e '+---------------------------------------------------------------+'
    echo -e "   运行环境  ${yellow}${docker_v}${plain}"
    echo -e "             ${yellow}${docker_compose_v}${plain}"
    echo -e "   系统时间  ${yellow}$(date "+%Y-%m-%d %H:%M:%S")${plain}"
    echo -e "   运行命令  ${yellow}bash <(curl -sSL https://raw.githubusercontent.com/Calle-99/shell/main/docker.sh)${plain}"
    echo -e "+---------------------------------------------------------------+
    ❖ ${green}Docker控制台${plain}  ${red}${VERSION}${plain}
    ###############${black}容器命令${plain}##############################
    ${green}1.${plain}查看所有容器             ${green}2.${plain}重启容器
    ${green}3.${plain}启动容器                 ${green}4.${plain}停止容器
    ${green}5.${plain}删除容器                 ${green}6.${plain}停止并删除容器
    ${green}7.${plain}进入容器内部             ${green}8.${plain}热更新容器镜像
    ${green}9.${plain}已有的容器改为自动重启
    ###############${black}镜像命令${plain}##############################
    ${green}20.${plain}查看所有镜像            ${green}21.${plain}删除镜像
    ###############${black}Docker Compose命令${plain}####################
    ${green}40.${plain}启动容器                ${green}41.${plain}停止容器
    ${green}42.${plain}重启容器                ${green}43.${plain}删除容器
    ${green}44.${plain}查看容器日志
    #####################################################
    ${yellow}0.${plain}退出脚本                 ${green}99.${plain}显示容器资源的使用情况
    #####################################################"
    CHOICE_A=$(echo -e "\n${bold}    └─ 请输入命令编号：${plain}")
    read -p "${CHOICE_A}" num


    case $num in    
    
    
    1) ps_a ;;
    2) restart ;;
    3) start ;;
    4) stop ;;
    5) rm ;;
    6) stop+rm ;;
    7) exec ;;
    8) update ;;
    9) always ;;
    20) images ;;
    21) rm_images ;;
    40) Compose_up_d ;;
    41) Compose_stop ;;
    42) Compose_restart ;;
    43) Compose_rm ;;
    44) Compose_logs_f ;;
    99)
        stats
        ;;
    0) exit 0 ;;
    *) clear && docker_sh ;;
    esac
}


docker_sh
