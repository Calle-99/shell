#!/bin/bash

## 清屏
    clear

echo "请选择要运行的代码序号："
echo "1. backtrace三网回程路由检测"
echo "2. mtr三网回程路由检测"
echo "3. SuperSpeed 三网全面测速"
echo "4. 仅进行 speedtest 国内三网测速"
echo "5. 流媒体测试"
echo "6. 国内外网络测速+流媒体测试"

read choice

case $choice in
    1)
        curl https://raw.githubusercontent.com/zhanghanyun/backtrace/main/install.sh -sSf | sh
        ;;
    2)
        curl https://raw.githubusercontent.com/zhucaidan/mtr_trace/main/mtr_trace.sh|bash
        ;;
    3)
        bash <(curl -Lso- https://git.io/superspeed_uxh)
        ;;
    4)
        bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh) --speed
        ;;
    5)
        bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench.sh) -m
        ;;
    6)
        bash <(wget -qO- https://down.vpsaff.net/linux/speedtest/superbench-dev.sh) --no-geek
        ;;
    *)
        echo "无效的选择"
        exit 1
        ;;
esac

exit 0