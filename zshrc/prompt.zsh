
# prompt.zsh


# --- Настройка кастомных ярких цветов ---
# Задаем переменные для 256-цветных кодов, чтобы PS1 был читаемым.
# Это ваш оригинальный, правильный подход для получения ярких цветов.
local red_bright="009"
local green_bright="010"
local yellow_bright="011"
local blue_bright="014"

# --- Настройка строки приглашения (PS1) ---
# Используем переменные с кодами цветов внутри %F{...}
# %F{<number>} - начало цвета по его коду, %f - сброс цвета
# %n - имя пользователя
# %m - имя хоста
# %~ - путь (с тильдой для дома)
# %# - символ '>' (для обычного пользователя) или '#' (для root)
PS1=$'\n\n'"%F{$red_bright}╭─[%F{$green_bright}%n%F{$yellow_bright}@%F{$blue_bright}%m%F{$red_bright}]-[%F{$green_bright}%~%F{$red_bright}]"$'\n'"╰─╼ %F{$yellow_bright}%# %f"

# Очищаем переменные, чтобы они не "засоряли" сессию
unset red_bright green_bright yellow_bright blue_bright
