#!/bin/bash

# Устанавливаем локаль для корректной работы с UTF-8
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# Проверяем, запущен ли Spotify
if ! pgrep -x spotify > /dev/null; then
    echo '{"text": "󰓛", "class": "stopped", "tooltip": "Spotify не запущен"}'
    exit 0
fi

# Проверяем статус
if ! playerctl --player=spotify status > /dev/null 2>&1; then
    echo '{"text": "󰓛", "class": "stopped", "tooltip": "Spotify"}'
    exit 0
fi

status=$(playerctl --player=spotify status 2>/dev/null)

# Определяем иконку и класс
case "$status" in
    "Playing")
        icon="󰎈"
        class="playing"

        # Пытаемся получить информацию о треке
        title=$(playerctl --player=spotify metadata --format '{{title}}' 2>/dev/null | head -c 30)
        artist=$(playerctl --player=spotify metadata --format '{{artist}}' 2>/dev/null | head -c 20)

        if [ -n "$title" ] && [ -n "$artist" ]; then
            # Очищаем от не-UTF8 символов
            title_clean=$(echo "$title" | iconv -c -f utf-8 -t utf-8 2>/dev/null || echo "")
            artist_clean=$(echo "$artist" | iconv -c -f utf-8 -t utf-8 2>/dev/null || echo "")

            if [ -n "$title_clean" ] && [ -n "$artist_clean" ]; then
                tooltip="${artist_clean} - ${title_clean}"
            else
                tooltip="Сейчас играет"
            fi
        else
            tooltip="Сейчас играет"
        fi

        echo "{\"text\": \"$icon\", \"class\": \"$class\", \"tooltip\": \"$tooltip\"}"
        ;;

    "Paused")
        echo '{"text": "󰏤", "class": "paused", "tooltip": "Пауза"}'
        ;;

    *)
        echo '{"text": "󰓛", "class": "stopped", "tooltip": "Spotify"}'
        ;;
esac
