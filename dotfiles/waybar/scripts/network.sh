#!/bin/bash

# Проверяем соединение
if ping -c 1 -W 1 8.8.8.8 &> /dev/null; then
    # Получаем имя сети Wi-Fi
    if iwgetid -r &> /dev/null; then
        ssid=$(iwgetid -r)
        signal=$(awk '/wlan0:/{print $3}' /proc/net/wireless | cut -d. -f1)
        echo "󰖩 $ssid ($signal%)"
    else
        echo "󰈀 Wired"
    fi
else
    echo "󰖪 Offline"
fi
