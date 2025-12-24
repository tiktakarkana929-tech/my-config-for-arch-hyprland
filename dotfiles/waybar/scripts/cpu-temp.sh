#!/bin/bash

# Получаем использование CPU
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
cpu_usage=${cpu_usage%.*}

# Получаем температуру CPU
temp_path=""
if [ -f "/sys/class/hwmon/hwmon2/temp1_input" ]; then
    temp_path="/sys/class/hwmon/hwmon2/temp1_input"
elif [ -f "/sys/class/hwmon/hwmon1/temp1_input" ]; then
    temp_path="/sys/class/hwmon/hwmon1/temp1_input"
elif [ -f "/sys/class/thermal/thermal_zone0/temp" ]; then
    temp_path="/sys/class/thermal/thermal_zone0/temp"
fi

if [ -n "$temp_path" ]; then
    temp_raw=$(cat $temp_path)
    temp_c=$((temp_raw / 1000))
else
    temp_c="N/A"
fi

# Выбираем иконку в зависимости от нагрузки
if [ $cpu_usage -lt 30 ]; then
    icon="󰍛"
elif [ $cpu_usage -lt 60 ]; then
    icon="󰍛"
elif [ $cpu_usage -lt 80 ]; then
    icon="󰍛"
else
    icon="󰍛"
fi

echo "{\"text\": \"$cpu_usage%  ${temp_c}°C\", \"icon\": \"$icon\", \"tooltip\": \"CPU: $cpu_usage%\\nTemp: ${temp_c}°C\"}"
