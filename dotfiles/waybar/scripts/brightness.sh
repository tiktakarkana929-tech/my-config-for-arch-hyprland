#!/bin/bash

# Получаем текущую яркость
brightness=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

# Выбираем иконку в зависимости от уровня яркости
if [ "$brightness" -eq 0 ]; then
    icon="󰃞"
    color="#ffb4ab"
elif [ "$brightness" -lt 25 ]; then
    icon="󰃞"
    color="#f5c2e7"
elif [ "$brightness" -lt 50 ]; then
    icon="󰃟"
    color="#f5c2e7"
elif [ "$brightness" -lt 75 ]; then
    icon="󰃝"
    color="#f5c2e7"
else
    icon="󰃠"
    color="#a6e3a1"
fi

# Формируем JSON вывод
echo "{\"text\": \"$brightness%\", \"icon\": \"$icon\", \"alt\": \"$brightness%\", \"tooltip\": \"Яркость: $brightness%\", \"class\": \"custom-brightness\"}"
