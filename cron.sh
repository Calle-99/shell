#!/bin/bash

add_cron_job() {
    read -p "请输入执行命令：" script_path
    read -p "请输入时间规则（例如：0 15 * * *）：" time_rule

    (crontab -l ; echo "$time_rule $script_path") | crontab -
    echo "已成功添加 cron 任务！"
}

remove_cron_job() {
    crontab -l > temp_cron
    if [ ! -s temp_cron ]; then
        echo "没有找到任何 cron 任务。"
        rm temp_cron
        return
    fi

    echo "请选择要删除的 cron 任务："
    awk '{print NR ". " $0}' temp_cron
    
    read -p "请输入要删除的任务序号：" index
    
    if [[ "$index" =~ ^[1-9][0-9]*$ ]]; then
        sed -i "${index}d" temp_cron
        crontab temp_cron
        rm temp_cron
        echo "已成功删除 cron 任务。"
    else
        echo "无效的序号，请重新运行脚本并选择有效的序号。"
        rm temp_cron
        return
    fi    
}

while true; do
    echo ""
    echo "请选择操作："
    echo "1. 添加 cron 任务"
    echo "2. 删除 cron 任务"
    echo "3. 退出"

	read -p "请输入选项（1-3）：" choice

	if [ "$choice" == '1' ]; then
		add_cron_job
	
	elif [ "$choice" == '2' ]; then
		remove_cron_job
	
	elif [ "$choice" == '3' ]; then
		break
	
	else
		echo "无效的选项，请重新选择。"
	fi

done
